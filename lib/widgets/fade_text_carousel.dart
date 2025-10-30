

import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/text_styles.dart';

class FadeTextCarousel extends StatefulWidget {
  const FadeTextCarousel({super.key});

  @override
  State<FadeTextCarousel> createState() => _FadeTextCarouselState();
}

class _FadeTextCarouselState extends State<FadeTextCarousel> {
  final List<String> texts = [
    "Because everyone needs a moment to rise, to heal, to fight, to feel alive "
        "again.",
    "MUSEiT has the ability to bring your people to power you through life.",
    "What could you do in a day if you had your people with you?",
    "Sometimes it’s hard to say what you want in that moment. Let’s make the "
        "moment now.",
    "The moment you need, without you knowing it.",
    "Time moves forward, but memories stay for life.",
    "You’ve got this. Can you feel it?",
    "What happens if you fall, but you could fly?",
    "What is your superpower? Belief."
  ];

  int _index = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        _index = (_index + 1) % texts.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/left_comma.png', height: 14, width: 14),
          const SizedBox(height: 3),
          Expanded(
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
                child: Text(
                  texts[_index],
                  key: ValueKey<int>(_index),
                  style: manRope.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              'assets/images/right_comma.png',
              height: 14,
              width: 14,
            ),
          ),
        ],
      ),
    );
  }
}