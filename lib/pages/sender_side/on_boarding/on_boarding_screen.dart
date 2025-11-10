import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/select_role/select_role_screen.dart';
import 'package:musit/widgets/custom_button.dart';

import 'controller/on_boarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: PageView.builder(
          controller: controller.pageController,
          itemCount: controller.images.length,
          onPageChanged: controller.onPageChanged,
          itemBuilder: (context, index) {
            return Column(
              children: [
                // ==== Image Section ====
                SizedBox(
                  height: Get.height * 0.35,
                  child: Stack(
                    children: [
                      Image.asset(
                        controller.images[index],
                        height: Get.height * 0.35,
                        width: Get.width,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: Get.width,
                          height: Get.height * 0.1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0.0),
                                Colors.white,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // ==== Text Section ====
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    controller.textTitles[index],
                    style: manRopeSemiBold.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),

                // ==== Text Section ====
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    controller.texts[index],
                    style: manRope,
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 25),

                // ==== Dots Section ====
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.images.length,
                        (dotIndex) {
                          final isActive =
                              controller.currentPage.value == dotIndex;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isActive ? blackColor : null,
                                gradient: isActive
                                    ? null
                                    : LinearGradient(
                                        colors: gradientColor,
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                    )),

                const Spacer(),

                // ==== Button Section ====
                Obx(() => CustomButton(
                      onPressed: () {
                        if (controller.currentPage.value ==
                            controller.images.length - 1) {
                          Get.offAll(() => SelectRoleScreen());
                        } else {
                          controller.pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      text: controller.currentPage.value ==
                              controller.images.length - 1
                          ? 'Get Started'
                          : 'Next',
                    )),

                const SizedBox(height: 16),

                // ==== Skip Button ====
                Obx(() => Visibility(
                      visible: controller.currentPage.value !=
                          controller.images.length - 1,
                      child: GestureDetector(
                        onTap: () {
                          Get.offAll(() => SelectRoleScreen());
                        },
                        child: Text(
                          'Skip',
                          style: manRopeSemiBold.copyWith(
                            fontSize: 14,
                            decorationColor: blackColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    )),

                const SizedBox(height: 24),
              ],
            );
          },
        ),
      ),
    );
  }
}
