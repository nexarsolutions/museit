import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/recipient_side/health_support/health_support_details/widget/transaction_card.dart';
import 'package:musit/pages/recipient_side/home/recipient_home/recipient_home_screen.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../constants/text_styles.dart';
import 'controlelr/recipient_health_details_controller.dart';

class RecipientHealthSupportDetailsScreen extends StatelessWidget {
  RecipientHealthSupportDetailsScreen({super.key});
  final controller = Get.put(RecipientHealthDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(
            text: 'Health Support',
            isBack: true,
            onTap: () {
              Get.offAll(() => RecipientHomeScreen());
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: const BoxDecoration(
                            color: blackColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              topLeft: Radius.circular(16),
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/charity.png',
                                scale: 3.2,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Total Donations',
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
                          '\$5651',
                          style: manRopeSemiBold.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Edit info',
                          style: manRopeSemiBold.copyWith(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            decorationColor: blackColor,
                          ),
                        ),
                        const SizedBox(height: 23),
                      ],
                    ),
                  ),
                  const SizedBox(height: 23),
                  Text(
                    'History of Payments',
                    style: manRopeSemiBold.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    padding: EdgeInsets.only(bottom: 30),
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    itemCount: controller.transactionsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: TransactionCard(
                          model: controller.transactionsList[index],
                        ),
                      );
                    },
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
