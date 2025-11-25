import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageCarouselSlider extends StatelessWidget {
  final List<String> images;
  const ImageCarouselSlider(this.images, {super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: Get.height * 0.5,
        viewportFraction: 1.0, // full width
        autoPlay: false,
        // autoPlayInterval: const Duration(seconds: 3),
        // autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enableInfiniteScroll: false,
        scrollDirection: Axis.horizontal,
      ),
      items: images.map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Image.asset(
              imagePath,
              height: Get.height * 0.35,
              width: Get.width,
              fit: BoxFit.cover,
            );
          },
        );
      }).toList(),
    );
  }
}
