import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/widgets/error_widget_future_stream.dart';
import '../../../../constants/text_styles.dart';
import '../../../../widgets/custom_header.dart';
import '../../charity_profile/charity_profile/charity_profile_screen.dart';
import 'controller/charity_home_controller.dart';

class CharityHomeScreen extends StatelessWidget {
  CharityHomeScreen({super.key});

  final controller = Get.put(CharityHomeController());

  @override
  Widget build(BuildContext context) {
    // Local function to build a reusable metric card widget

    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomHeader(
            onTap: () {
              Get.to(() => CharityProfileScreen());
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  FutureBuilder(
                      future: controller.charityOverview(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ErrorWidgetFutureStream();
                        }
                        if (snapshot.hasError) {
                          return ErrorWidgetFutureStream(
                            error: snapshot.error.toString(),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data == null) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildMetricCard(
                                imagePath: 'assets/images/charity.png',
                                title: 'Total Donations',
                                value: '£0',
                              ),
                              const SizedBox(height: 10),
                              buildMetricCard(
                                imagePath: 'assets/images/donations.png',
                                title: 'Active Campaigns',
                                value: '0',
                              ),
                            ],
                          );
                        }

                        final dashboard = snapshot.requireData!;

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            buildMetricCard(
                              imagePath: 'assets/images/charity.png',
                              title: 'Total Donations',
                              value: '£${dashboard['totalDonations']}',
                            ),
                          ],
                        );
                      }),
                  const SizedBox(height: 49),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMetricCard({
    required String imagePath,
    required String title,
    required String value,
  }) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8C7FAC).withOpacity(0.15),
            const Color(0xFF7695CA).withOpacity(0.15),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: blackColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Image.asset(imagePath, scale: 3.2),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: manRopeSemiBold.copyWith(
                      fontSize: 14,
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 23),
          Text(
            value,
            style: manRopeSemiBold.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 23),
          const SizedBox(height: 23),
        ],
      ),
    );
  }

  Widget buildSmallCard({required String title, required String image}) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 100,
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 41,
            bottom: 13,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF8C7FAC).withOpacity(0.15),
                const Color(0xFF7695CA).withOpacity(0.15),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: darkGrey.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: manRopeSemiBold.copyWith(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Positioned(top: -35, child: Image.asset(image, width: 70, height: 70)),
      ],
    );
  }
}
