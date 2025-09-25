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

class RecievedSongsMusicPlayerScreen extends StatefulWidget {
  const RecievedSongsMusicPlayerScreen({super.key, required this.imagePath});
  final String imagePath;
  @override
  _RecievedSongsMusicPlayerScreenState createState() =>
      _RecievedSongsMusicPlayerScreenState();
}

class _RecievedSongsMusicPlayerScreenState
    extends State<RecievedSongsMusicPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late PlayerController _waveformController;

  final RxBool isPlaying = false.obs;
  final Rx<Duration> totalDuration = Duration.zero.obs;
  final Rx<Duration> playedDuration = Duration.zero.obs;
  final RxInt currentSongIndex = 0.obs;
  final RxBool isSaved = false.obs;
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
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.imagePath),
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
              CustomAppBar(
                text: '',
                isBack: true,
                showLastIcon: true,
                lastWidget: Obx(
                  () => GestureDetector(
                    onTap: () {
                      isSaved.value = !isSaved.value;
                    },
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: blackColor,
                      ),
                      child: Image.asset(
                        isSaved.value
                            ? 'assets/images/saved_filled.png'
                            : 'assets/images/saved_icon.png',
                        scale: 4,
                      ),
                    ),
                  ),
                ),
              ),
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
                          image: DecorationImage(
                            image: AssetImage(widget.imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Obx(() {
                        final title =
                            playlist[currentSongIndex.value]["title"]!;
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
                      SizedBox(
                        width: Get.width,
                        height: 120.0,
                        child: GestureDetector(
                          onTapDown: (details) {
                            final frac = details.localPosition.dx / Get.width;
                            _seekToFraction(frac);
                          },
                          child: Obx(() {
                            // Check if a song is loaded before showing the waveform
                            if (totalDuration.value == Duration.zero) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return AudioFileWaveforms(
                              waveformType: WaveformType.fitWidth,
                              size: Size(Get.width, 120),
                              playerController: _waveformController,
                              enableSeekGesture:
                                  true, // Enable seeking via gesture
                              playerWaveStyle: const PlayerWaveStyle(
                                showSeekLine:
                                    false, // Keep the seek line hidden
                                spacing: 4,
                                waveThickness: 1.5,
                                // Use a gradient to create the "outlay" effect
                                // gradient: LinearGradient(
                                //   colors: [
                                //     Colors.white, // The 'played' part will be solid white
                                //     Colors.white24, // The 'unplayed' part will be transparent white
                                //   ],
                                //   stops: [0.0, 1.0],
                                //   begin: Alignment.centerLeft,
                                //   end: Alignment.centerRight,
                                // ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Obx(() {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDuration(playedDuration.value),
                                style: manRopeSemiBold.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                _formatDuration(totalDuration.value),
                                style: manRopeSemiBold.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/shuffle_icon.png',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 30),
                          GestureDetector(
                            onTap: _playPreviousSong,
                            child: Image.asset(
                              'assets/images/play_previous.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const SizedBox(width: 22),
                          GestureDetector(
                            onTap: () async {
                              if (totalDuration.value == Duration.zero &&
                                  !isPlaying.value) {
                                await _playSong(currentSongIndex.value);
                                return;
                              }
                              await _togglePlayPause();
                            },
                            child: Obx(
                              () => Image.asset(
                                isPlaying.value
                                    ? 'assets/images/pause.png'
                                    : 'assets/images/play.png',
                                width: 32,
                                height: 32,
                              ),
                            ),
                          ),
                          const SizedBox(width: 22),
                          GestureDetector(
                            onTap: _playNextSong,
                            child: Image.asset(
                              'assets/images/play_next.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                          const SizedBox(width: 30),
                          Image.asset(
                            'assets/images/repeat.png',
                            width: 20,
                            height: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/dummy_profile.png',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Kathy James',
                                  style: manRopeSemiBold.copyWith(
                                    fontSize: 14,
                                    color: whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Price Paid',
                                style: manRopeSemiBold.copyWith(
                                  fontSize: 12,
                                  color: whiteColor,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                '25p',
                                style: manRopeSemiBold.copyWith(
                                  fontSize: 14,
                                  color: whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildRecordingCard(
                        title: "Recording 1",
                        duration: "05:47 min",
                      ),
                      const SizedBox(height: 8),
                      _buildRecordingCard(
                        title: "Recording 2",
                        duration: "03:22 min",
                      ),
                      const SizedBox(height: 24),

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

  Widget _buildRecordingCard({
    required String title,
    required String duration,
  }) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          // ✅ Custom Borders
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border(
                  left: BorderSide(color: whiteColor, width: 0.3),
                  right: BorderSide(color: whiteColor, width: 0.3),
                  bottom: BorderSide(color: whiteColor, width: 0.3),
                ),
              ),
            ),
          ),

          // ✅ Content
          Padding(
            padding: const EdgeInsets.only(
              left: 6,
              right: 20,
              top: 6,
              bottom: 6,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile image
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: whiteColor,
                  ),
                  child: Image.asset(
                    'assets/images/recording_icon.png',
                    scale: 3,
                    color: blackColor,
                  ),
                ),
                const SizedBox(width: 12),

                // Name + Duration
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: manRopeSemiBold.copyWith(
                          fontSize: 12,
                          color: whiteColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        duration,
                        style: manRope.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 10,
                          color: lightWhite,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
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
  Rect getClip(Size size) =>
      Rect.fromLTWH(0, 0, width.clamp(0.0, size.width), size.height);
  @override
  bool shouldReclip(covariant _LeftClipper oldClipper) =>
      oldClipper.width != width;
}
