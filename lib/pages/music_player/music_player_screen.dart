import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/widgets/custom_app_bar.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final RxBool isPlaying = false.obs;
  final Rx<Duration> totalDuration = Duration.zero.obs;
  final Rx<Duration> playedDuration = Duration.zero.obs;

  final List<String> playlist = [
    // Public domain music URLs from SoundHelix
    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    // Public domain music URLs from Bensound
    'https://www.bensound.com/bensound-music/bensound-epic.mp3',
    'https://www.bensound.com/bensound-music/bensound-jazzyfrenchy.mp3',
  ];
  final RxInt currentSongIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    // Listen for duration changes
    audioPlayer.onDurationChanged.listen((Duration d) {
      totalDuration.value = d;
    });

    // Listen for position changes
    audioPlayer.onPositionChanged.listen((Duration p) {
      playedDuration.value = p;
    });

    // Handle end of song to play the next one
    audioPlayer.onPlayerComplete.listen((event) {
      _playNextSong();
    });

    // Start playing the first song
    _playSong(currentSongIndex.value);
  }

  Future<void> _playSong(int index) async {
    final songUrl = playlist[index];
    await audioPlayer.play(UrlSource(songUrl));
    isPlaying.value = true;
  }

  void _togglePlayPause() async {
    if (isPlaying.value) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.resume();
    }
    isPlaying.value = !isPlaying.value;
  }

  void _playNextSong() {
    if (currentSongIndex.value < playlist.length - 1) {
      currentSongIndex.value++;
    } else {
      currentSongIndex.value = 0; // Loop back to the beginning
    }
    _playSong(currentSongIndex.value);
  }

  void _playPreviousSong() {
    if (currentSongIndex.value > 0) {
      currentSongIndex.value--;
    } else {
      currentSongIndex.value = playlist.length - 1; // Loop to the end
    }
    _playSong(currentSongIndex.value);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    audioPlayer.dispose();
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
          Container(
            width: Get.width,
            height: Get.height,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      blackColor.withOpacity(0.9),
                      blackColor.withOpacity(0.9),
                    ],
                  ),
                ),
              ),
            ),
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
                      Text(
                        'Online Music',
                        style: manRopeSemiBold.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Duration display
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
                            onTap: _togglePlayPause,
                            child: Obx(
                                  () => Image.asset(
                                isPlaying.value ? 'assets/images/pause.png' : 'assets/images/play.png',
                                width: 24,
                                height: 24,
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