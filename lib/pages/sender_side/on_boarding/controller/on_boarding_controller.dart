import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  final pageController = PageController();
  RxInt currentPage = 0.obs;

  final List<String> images = [
    'assets/images/on_boarding_1.png',
    'assets/images/on_boarding_2.png',
    'assets/images/on_boarding_3.png',
  ];

  final List<String> texts = [
    'Welcome to Musit, your new sender_home for music discovery. We believe that every person has a unique soundtrack to their life. Dive in and explore a vast library of songs, artists, and albums, all waiting to be discovered by you.',
    'Our smart recommendations are here to guide you. Musit learns what you love to listen to and introduces you to new artists and genres you might have missed. Say goodbye to endless scrolling and hello to music that truly resonates with your soul.',
    'Ready to press play? From creating the perfect playlist for your workout to finding a relaxing tune for your commute, Musit is designed to fit seamlessly into your life. Tap "Get Started" to begin your personalized music journey today.',
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
