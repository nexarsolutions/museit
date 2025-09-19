import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:path_provider/path_provider.dart';

import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/widgets/custom_app_bar.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late PlayerController _waveformController;

  final RxBool isPlaying = false.obs;
  final Rx<Duration> totalDuration = Duration.zero.obs;
  final Rx<Duration> playedDuration = Duration.zero.obs;
  final RxInt currentSongIndex = 0.obs;

  final List<Map<String, String>> playlist = [
    {"title": "Relaxing Vibes", "path": "songs/song_1.mp3"},
    {"title": "Morning Energy", "path": "songs/song_2.mp3"},
    {"title": "Chill Night", "path": "songs/song_3.mp3"},
  ];

  @override
  void initState() {
    super.initState();
    _waveformController = PlayerController();
    _initAudioListeners();
  }

  void _initAudioListeners() {
    _audioPlayer.onDurationChanged.listen((d) {
      totalDuration.value = d;
    });

    _audioPlayer.onPositionChanged.listen((p) {
      playedDuration.value = p;
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      _playNextSong();
    });
  }

  Future<File> _copyAssetToFile(String assetPath) async {
    final byteData = await rootBundle.load("assets/$assetPath");
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/${assetPath.split('/').last}');
    await tempFile.writeAsBytes(
      byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
      flush: true,
    );
    return tempFile;
  }

  Future<void> _prepareWaveform(String assetPath) async {
    final file = await _copyAssetToFile(assetPath);
    await _waveformController.preparePlayer(
      path: file.path,
      shouldExtractWaveform: true,
      noOfSamples: 200,
    );
  }

  Future<void> _playSong(int index) async {
    final songPath = playlist[index]["path"]!;

    await _audioPlayer.stop();

     _waveformController.dispose();
    _waveformController = PlayerController();

    await _prepareWaveform(songPath);

    await _audioPlayer.play(AssetSource(songPath));

    isPlaying.value = true;
  }

  Future<void> _togglePlayPause() async {
    if (!isPlaying.value) {
      if (totalDuration.value == Duration.zero) {
        await _playSong(currentSongIndex.value);
        return;
      }
      await _audioPlayer.resume();
      isPlaying.value = true;
    } else {
      await _audioPlayer.pause();
      isPlaying.value = false;
    }
  }

  Future<void> _playNextSong() async {
    await _audioPlayer.stop();
    isPlaying.value = false;
    if (currentSongIndex.value < playlist.length - 1) {
      currentSongIndex.value++;
    } else {
      currentSongIndex.value = 0;
    }
    totalDuration.value = Duration.zero;
    playedDuration.value = Duration.zero;
    await _playSong(currentSongIndex.value);
  }

  Future<void> _playPreviousSong() async {
    await _audioPlayer.stop();
    isPlaying.value = false;
    if (currentSongIndex.value > 0) {
      currentSongIndex.value--;
    } else {
      currentSongIndex.value = playlist.length - 1;
    }
    totalDuration.value = Duration.zero;
    playedDuration.value = Duration.zero;
    await _playSong(currentSongIndex.value);
  }

  Future<void> _seekToFraction(double fraction) async {
    final totalMs = totalDuration.value.inMilliseconds;
    if (totalMs <= 0) return;
    final posMs = (totalMs * fraction).clamp(0, totalMs).toInt();
    await _audioPlayer.seek(Duration(milliseconds: posMs));
    playedDuration.value = Duration(milliseconds: posMs);
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final m = twoDigits(d.inMinutes.remainder(60));
    final s = twoDigits(d.inSeconds.remainder(60));
    return '$m:$s';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _waveformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/thumbnail_2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(color: blackColor.withOpacity(0.9)),
          ),
          Column(
            children: [
              const CustomAppBar(text: '', isBack: true),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Container(
                        width: Get.width,
                        height: Get.height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/thumbnail_2.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Obx(() {
                        final title = playlist[currentSongIndex.value]["title"]!;
                        return Text(
                          title,
                          style: manRopeSemiBold.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        );
                      }),
                      const SizedBox(height: 24),
                      LayoutBuilder(builder: (context, constraints) {
                        final width = constraints.maxWidth;
                        final height = 120.0;
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTapDown: (details) {
                            final dx = details.localPosition.dx.clamp(0.0, width);
                            final frac = dx / width;
                            _seekToFraction(frac);
                          },
                          onHorizontalDragUpdate: (details) {
                            final dx = details.localPosition.dx.clamp(0.0, width);
                            final frac = dx / width;
                            _seekToFraction(frac);
                          },
                          child: SizedBox(
                            width: width,
                            height: height,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: AudioFileWaveforms(
                                    size: Size(width, height),
                                    playerController: _waveformController,
                                    enableSeekGesture: false,
                                    waveformType: WaveformType.fitWidth,
                                    continuousWaveform: true,
                                    playerWaveStyle: const PlayerWaveStyle(
                                      fixedWaveColor: Colors.white24,
                                      liveWaveColor: Colors.white24,
                                      spacing: 4,
                                      waveThickness: 2,
                                      showTop: true,
                                      showBottom: true,
                                    ),
                                  ),
                                ),
                                Obx(() {
                                  final totalMs = totalDuration.value.inMilliseconds;
                                  final playedMs = playedDuration.value.inMilliseconds;
                                  final frac = (totalMs > 0) ? (playedMs / totalMs).clamp(0.0, 1.0) : 0.0;
                                  final clipWidth = width * frac;
                                  return ClipRect(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        width: width,
                                        height: height,
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: AudioFileWaveforms(
                                                size: Size(width, height),
                                                playerController: _waveformController,
                                                enableSeekGesture: false,
                                                waveformType: WaveformType.fitWidth,
                                                continuousWaveform: true,
                                                playerWaveStyle: const PlayerWaveStyle(
                                                  fixedWaveColor: Colors.white,
                                                  liveWaveColor: Colors.white,
                                                  spacing: 4,
                                                  waveThickness: 2,
                                                  showTop: true,
                                                  showBottom: true,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: clipWidth,
                                              top: 0,
                                              bottom: 0,
                                              right: 0,
                                              child: Container(
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    clipper: _LeftClipper(width: clipWidth),
                                  );
                                }),
                              ],
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 24),
                      Obx(() {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDuration(playedDuration.value),
                                style: manRopeSemiBold.copyWith(color: Colors.white),
                              ),
                              Text(
                                _formatDuration(totalDuration.value),
                                style: manRopeSemiBold.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/shuffle_icon.png', width: 20, height: 20),
                          const SizedBox(width: 30),
                          GestureDetector(
                            onTap: _playPreviousSong,
                            child: Image.asset('assets/images/play_previous.png', width: 24, height: 24),
                          ),
                          const SizedBox(width: 22),
                          GestureDetector(
                            onTap: () async {
                              if (totalDuration.value == Duration.zero && !isPlaying.value) {
                                await _playSong(currentSongIndex.value);
                                return;
                              }
                              await _togglePlayPause();
                            },
                            child: Obx(
                                  () => Image.asset(
                                isPlaying.value ? 'assets/images/pause.png' : 'assets/images/play.png',
                                width: 32,
                                height: 32,
                              ),
                            ),
                          ),
                          const SizedBox(width: 22),
                          GestureDetector(
                            onTap: _playNextSong,
                            child: Image.asset('assets/images/play_next.png', width: 24, height: 24),
                          ),
                          const SizedBox(width: 30),
                          Image.asset('assets/images/repeat.png', width: 20, height: 20),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LeftClipper extends CustomClipper<Rect> {
  final double width;
  _LeftClipper({required this.width});
  @override
  Rect getClip(Size size) => Rect.fromLTWH(0, 0, width.clamp(0.0, size.width), size.height);
  @override
  bool shouldReclip(covariant _LeftClipper oldClipper) => oldClipper.width != width;
}