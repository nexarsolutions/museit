import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:music_kit/music_kit.dart';

import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/services/apple_music_service.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({
    super.key,
    required this.songTitle,
    required this.songUrl,
    required this.imagePath,
    this.typeId,
    this.appleMusicSongId, // Library song ID for Apple Music (e.g., "i.ZOMrKa1SrEPK64q")
  });

  final String songTitle;
  final String songUrl; // can be asset path or network URL
  final String imagePath;
  final int? typeId; // 3 for Apple Music
  final String? appleMusicSongId; // Apple Music library song ID

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late final PlayerController _waveformController;
  final AppleMusicService _appleMusicService = AppleMusicService();
  StreamSubscription<MusicPlayerState>? _musicKitSubscription;

  final RxBool isPlaying = false.obs;
  final Rx<Duration> totalDuration = Duration.zero.obs;
  final Rx<Duration> playedDuration = Duration.zero.obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isAppleMusic = false.obs;

  @override
  void initState() {
    super.initState();
    _waveformController = PlayerController();
    isAppleMusic.value = widget.typeId == 3;
    
    if (isAppleMusic.value) {
      _initMusicKitListeners();
      _initializeAppleMusicPlayer();
    } else {
      _initAudioListeners();
      _initializePlayer();
    }
  }

  void _initMusicKitListeners() {
    _musicKitSubscription = _appleMusicService.playbackState.listen((state) {
      if (!mounted) return;
      
      try {
        // Update playing state - check state properties dynamically
        // MusicPlayerState structure may vary by package version
        final stateString = state.toString();
        isPlaying.value = stateString.contains('playing') || 
                          stateString.contains('Playing');
        
        // Try to get duration and position from state
        // Note: Actual property names may differ - adjust based on package version
        debugPrint('MusicPlayerState: $state');
      } catch (e) {
        debugPrint('Error reading MusicPlayerState: $e');
      }
    });
  }

  /// Initialize Apple Music player using MusicKit
  Future<void> _initializeAppleMusicPlayer() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      debugPrint("🎵 Apple Music Song ID: ${widget.appleMusicSongId}");
      debugPrint("🖼️ Image Path: ${widget.imagePath}");

      if (widget.appleMusicSongId == null || widget.appleMusicSongId!.isEmpty) {
        errorMessage.value = 'Apple Music song ID is missing.';
        isLoading.value = false;
        return;
      }

      // Play the song using MusicKit
      // Pass the link (songUrl) which may contain the catalog ID
      await _appleMusicService.playLibrarySong(
        widget.appleMusicSongId!,
        link: widget.songUrl,
      );
      
      isLoading.value = false;
    } catch (e, st) {
      debugPrint("Apple Music playback failed: $e\n$st");
      errorMessage.value = 'Failed to play Apple Music song: $e';
      isLoading.value = false;
    }
  }

  void _initAudioListeners() {
    _audioPlayer.onDurationChanged.listen((d) {
      totalDuration.value = d;
    });

    _audioPlayer.onPositionChanged.listen((p) {
      // update played duration observable
      playedDuration.value = p;

      // sync waveform: seek waveform controller to current position (ms)
      try {
        _waveformController.seekTo(p.inMilliseconds);
      } catch (e) {
        // swallow—seekTo may throw if controller isn't ready yet
        debugPrint('waveform seekTo error: $e');
      }
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      isPlaying.value = false;
      playedDuration.value = totalDuration.value;

      // if (isLooping.value && widget.onNext != null) { widget.onNext!(); }
      try {
        _waveformController.setFinishMode(finishMode: FinishMode.stop);
      } catch (_) {}
    });
  }

  /// Initialize waveform + play setup
  Future<void> _initializePlayer() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      debugPrint("🎵 Song URL: ${widget.songUrl}");
      debugPrint("🖼️ Image Path: ${widget.imagePath}");
      debugPrint("🎵 Type ID: ${widget.typeId}");

      final filePath = await _getPlayablePath(widget.songUrl);

      // Prepare waveform from the local file path
      await _waveformController.preparePlayer(
        path: filePath,
        shouldExtractWaveform: true,
        noOfSamples: 200,
      );

      // Play the same local file so waveform and playback match
      await _audioPlayer.play(DeviceFileSource(filePath));
      isPlaying.value = true;
    } catch (e, st) {
      debugPrint("Waveform preparation failed: $e\n$st");
      errorMessage.value = 'Failed to load song: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Converts asset or network URL into a playable local file path
  Future<String> _getPlayablePath(String source) async {
    if (source.startsWith('http')) {
      // Download network file
      final file = await _downloadFile(source);
      return file.path;
    } else if (source.startsWith('assets/')) {
      // Asset file (bundled)
      return (await _copyAssetToTempFile(source)).path;
    } else {
      // Local file path already
      return source;
    }
  }

  /// Download network audio to a local temp file
  Future<File> _downloadFile(String url) async {
    final client = HttpClient();
    final request = await client.getUrl(Uri.parse(url));
    final response = await request.close();

    print("🔗 Spotify Response Code: ${response.statusCode}");
    print("🔗 Headers: ${response.headers}");

    if (response.statusCode != 200) {
      throw Exception('Failed to download file: ${response.statusCode}');
    }

    final bytes = await consolidateHttpClientResponseBytes(response);
    final tempDir = await getTemporaryDirectory();
    final sanitized =
        url.split('/').last.replaceAll(RegExp(r'[^A-Za-z0-9\._-]'), '_');
    final file = File('${tempDir.path}/$sanitized');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  /// Copy bundled asset to a temp location
  Future<File> _copyAssetToTempFile(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${assetPath.split('/').last}');
    await file.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
      flush: true,
    );
    return file;
  }

  Future<void> _togglePlayPause() async {
    if (isLoading.value || errorMessage.value.isNotEmpty) return;

    if (isAppleMusic.value) {
      // Apple Music playback control
      if (isPlaying.value) {
        await _appleMusicService.pause();
      } else {
        await _appleMusicService.resume();
      }
    } else {
      // Regular audio playback
      if (isPlaying.value) {
        await _audioPlayer.pause();
        await _waveformController.pausePlayer();
        isPlaying.value = false;
      } else {
        await _audioPlayer.resume();
        await _waveformController.startPlayer();
        isPlaying.value = true;
      }
    }
  }

  Future<void> _seekToFraction(double fraction) async {
    final totalMs = totalDuration.value.inMilliseconds;
    if (totalMs <= 0) return;
    final posMs = (totalMs * fraction).clamp(0, totalMs).toInt();
    final position = Duration(milliseconds: posMs);

    if (isAppleMusic.value) {
      await _appleMusicService.seekTo(position);
      playedDuration.value = position;
    } else {
      await _audioPlayer.seek(position);
      playedDuration.value = position;

      // also move waveform to the same position
      try {
        _waveformController.seekTo(posMs);
      } catch (e) {
        debugPrint('waveform seekTo (user) error: $e');
      }
    }
  }

  Future<void> _seekBySeconds(int seconds) async {
    final current = playedDuration.value.inSeconds;
    final newPosition =
        (current + seconds).clamp(0, totalDuration.value.inSeconds);
    final position = Duration(seconds: newPosition);
    
    if (isAppleMusic.value) {
      await _appleMusicService.seekTo(position);
      playedDuration.value = position;
    } else {
      await _audioPlayer.seek(position);
      playedDuration.value = position;
      await _waveformController.seekTo((newPosition * 1000));
    }
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final m = twoDigits(d.inMinutes.remainder(60));
    final s = twoDigits(d.inSeconds.remainder(60));
    return '$m:$s';
  }

  @override
  void dispose() {
    _musicKitSubscription?.cancel();
    _audioPlayer.dispose();
    _waveformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = widget.imagePath == ''
        ? null
        : widget.imagePath.startsWith('http')
            ? NetworkImage(widget.imagePath)
            : AssetImage(widget.imagePath) as ImageProvider;

    return Scaffold(
      body: Stack(
        children: [
          /// Background Image
          Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
              image: imageProvider == null
                  ? null
                  : DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),

          /// Blur Overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(color: blackColor.withOpacity(0.9)),
          ),

          /// Content
          Column(
            children: [
              const CustomAppBar(text: '', isBack: true),
              Expanded(
                child: Obx(() {
                  if (isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (errorMessage.value.isNotEmpty) {
                    return Center(
                      child: Text(
                        errorMessage.value,
                        style:
                            manRopeSemiBold.copyWith(color: Colors.redAccent),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        /// Song Image
                        Container(
                          width: Get.width,
                          height: Get.height * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: imageProvider == null
                                ? null
                                : DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        /// Song Title
                        Text(
                          widget.songTitle,
                          style: manRopeSemiBold.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),

                        /// Waveform with seek gesture (only for non-Apple Music)
                        Obx(() => isAppleMusic.value
                            ? Container(
                                height: 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'Apple Music playback',
                                    style: manRopeSemiBold.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : LayoutBuilder(
                                builder: (context, constraints) {
                                  return GestureDetector(
                                    onTapDown: (details) {
                                      final fraction = details.localPosition.dx /
                                          constraints.maxWidth;
                                      _seekToFraction(fraction);
                                    },
                                    child: AudioFileWaveforms(
                                      waveformType: WaveformType.fitWidth,
                                      size: Size(constraints.maxWidth, 120),
                                      playerController: _waveformController,
                                      enableSeekGesture: true,
                                      playerWaveStyle: const PlayerWaveStyle(
                                        showSeekLine: false,
                                        spacing: 4,
                                        waveThickness: 1.5,
                                      ),
                                    ),
                                  );
                                },
                              )),

                        const SizedBox(height: 24),

                        /// Duration Text
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDuration(playedDuration.value),
                                  style: manRopeSemiBold.copyWith(
                                      color: Colors.white),
                                ),
                                Text(
                                  _formatDuration(totalDuration.value),
                                  style: manRopeSemiBold.copyWith(
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: 24),

                        /// Controls
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/shuffle_icon.png',
                                width: 20, height: 20),
                            const SizedBox(width: 30),
                            GestureDetector(
                              onTap: () => _seekBySeconds(-10),
                              child: Image.asset(
                                  'assets/images/play_previous.png',
                                  width: 24,
                                  height: 24),
                            ),
                            const SizedBox(width: 22),
                            GestureDetector(
                              onTap: _togglePlayPause,
                              child: Obx(() => Image.asset(
                                    isPlaying.value
                                        ? 'assets/images/pause.png'
                                        : 'assets/images/play.png',
                                    width: 32,
                                    height: 32,
                                  )),
                            ),
                            const SizedBox(width: 22),
                            GestureDetector(
                              onTap: () => _seekBySeconds(10),
                              child: Image.asset('assets/images/play_next.png',
                                  width: 24, height: 24),
                            ),
                            const SizedBox(width: 30),
                            Image.asset('assets/images/repeat.png',
                                width: 20, height: 20),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
