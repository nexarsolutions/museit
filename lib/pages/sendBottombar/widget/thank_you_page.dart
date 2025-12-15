import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:share_plus/share_plus.dart';

import '../../../widgets/custom_button.dart';
import '../controller/sender_bottom_bar_controller.dart';

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/thank_you_page.jpg",
              fit: BoxFit.cover,
            ),
          ),

          /// DARK OVERLAY
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.55),
            ),
          ),

          /// CONTENT
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Close button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),

                  const Spacer(),

                  /// Center headline block
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "STOP CHASING TOMORROW.",
                                textAlign: TextAlign.center,
                                style: manRopeSemiBold.copyWith(
                                  color: Colors.white,
                                  fontSize: 14,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "CHASE MOMENTS.",
                                  textAlign: TextAlign.center,
                                  style: manRopeSemiBold.copyWith(
                                    color: Colors.white,
                                    fontSize: 14,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 1.5,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),

                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomButton(
                      width: double.infinity,
                      onPressed: () {
                        Get.back();
                        Get.find<SenderBottomBarController>()
                            .selectedTab
                            .value = 1;
                      },
                      text: "Send Another MUSEiT Moments",
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Share.share("""
                      Share the love even further
                      
                      https://apps.apple.com/us/app/museit-life/id6754285575
                      """);
                    },
                    child: Center(
                      child: Text(
                        "Share the love even further",
                        style: manRope.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  /// Bottom‑left countdown text
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "The countdown to\nlaunch begins!",
                          style: manRopeSemiBold.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Text(
                        //   "-10",
                        //   style: manRopeSemiBold.copyWith(
                        //     color: Colors.white,
                        //     fontSize: 16,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
