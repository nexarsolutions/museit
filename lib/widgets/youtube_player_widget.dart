import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../constants/colors.dart';

class YouTubeAudioPlayer extends StatefulWidget {
  final String videoUrl;

  const YouTubeAudioPlayer({super.key, required this.videoUrl});

  @override
  State<YouTubeAudioPlayer> createState() => _YouTubeAudioPlayerState();
}

class _YouTubeAudioPlayerState extends State<YouTubeAudioPlayer> {
  late YoutubePlayerController _controller;
  late String _videoId;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _videoId = YoutubePlayer.convertUrlToId(widget.videoUrl)!;

    _controller = YoutubePlayerController(
      initialVideoId: _videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true, // ✅ start playing automatically
        mute: false,
        hideControls: true,
        disableDragSeek: false,
      ),
    );

    _controller.addListener(_youtubeListener);
  }

  void _youtubeListener() {
    if (!mounted) return;
    final value = _controller.value;

    // Keep progress updated
    setState(() {
      _currentPosition = value.position;
      _totalDuration = value.metaData.duration;

      // ✅ Sync play/pause button automatically
      _isPlaying = value.isPlaying;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_youtubeListener);
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  Future<void> _togglePlayPause() async {
    // 👇 Update UI immediately for smooth feel
    setState(() => _isPlaying = !_isPlaying);

    // Then perform the real action
    if (_isPlaying) {
      _controller.play();
    } else {
      _controller.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    final thumbnailUrl = YoutubePlayer.getThumbnail(videoId: _videoId);

    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          // 🌈 Background blur
          Positioned.fill(
            child: Image.network(thumbnailUrl, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),
          ),

          // 🎧 Foreground UI
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 💿 Circular Album Image
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 25,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.network(
                          thumbnailUrl,
                          height: 250,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Title
                    Text(
                      _controller.metadata.title.isNotEmpty
                          ? _controller.metadata.title
                          : "Now Playing",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "YouTube Audio",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Slider (seek)
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 6),
                      ),
                      child: Slider(
                        value: _currentPosition.inSeconds.toDouble(),
                        min: 0,
                        max: _totalDuration.inSeconds.toDouble() > 0
                            ? _totalDuration.inSeconds.toDouble()
                            : 1,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white24,
                        onChanged: (value) {
                          _controller.seekTo(Duration(seconds: value.toInt()));
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(_currentPosition),
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12),
                        ),
                        Text(
                          _formatDuration(_totalDuration),
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // ⚡ Play/Pause Button
                    GestureDetector(
                      onTap: _togglePlayPause,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.4), width: 1.5),
                        ),
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            transitionBuilder: (child, anim) =>
                                ScaleTransition(scale: anim, child: child),
                            child: Icon(
                              _isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              key: ValueKey<bool>(_isPlaying),
                              color: Colors.white,
                              size: 45,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Hidden YouTube Player (no video shown)
                    SizedBox(
                      height: 1,
                      width: 1,
                      child: YoutubePlayer(controller: _controller),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
              top: 0,
              child: CustomAppBar(
                text: '',
                isBack: true,
              )),
        ],
      ),
    );
  }
}
