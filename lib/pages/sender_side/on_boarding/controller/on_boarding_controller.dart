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

  final List<String> textTitles = [
    '''
     Who?
    ''',
    '''
     What?
    ''',
    '''
    When?
    '''
  ];

  final List<String> texts = [
    '''
    MUSEiT was created by people who understand what it feels like to face life’s toughest
moments. We’ve been through grief, illness, and the challenges of finding strength when it
feels out of reach. Our founder, Amy Barrett, and the team built MUSEiT to connect people
through music, voice, and emotion—because no one should ever feel alone in their journey
    ''',
    '''
    MUSEiT is a platform that blends music, motivation, and heartfelt connection. It lets you send
or receive personalised playlists with spoken messages of encouragement, support, or
celebration. Whether it’s cheering someone through a marathon, lifting a loved one’s spirits, or
supporting a charity cause, MUSEiT helps you share care that truly speaks volumes.
    ''',
    '''
    MUSEiT is for every moment that matters. When someone’s struggling, when you can’t be
there in person, or when you simply want to make someone smile. It’s also for life’s
milestones—from birthdays to recoveries to big challenges. Whenever words aren’t enough,
MUSEiT gives you a way to send strength through sound.
    '''
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
