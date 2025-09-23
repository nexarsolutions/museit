import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/widgets/custom_app_bar.dart';

import '../../../../constants/text_styles.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../health/support_plan/widget/support_plan_widget.dart';
import '../../sender_home/playlist_sent_bottom_sheet/playlist_sent_bottom_sheet.dart';
import 'controller/paid_songs_payment_details_controller.dart';

class PaidSongsPaymentDetailsScreen extends StatelessWidget {
  PaidSongsPaymentDetailsScreen({super.key});
  final controller = Get.put(PaidSongsPaymentDetailsController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Payment Details', isBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusGeometry.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF8C7FAC).withValues(alpha: 0.15),
                          Color(0xFF7695CA).withValues(alpha: 0.15),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: Get.width,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius: BorderRadiusGeometry.only(
                              topRight: Radius.circular(16),
                              topLeft: Radius.circular(16),
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/dollar.png',
                                scale: 3.2,
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Payment Summary',
                                  style: manRopeSemiBold.copyWith(
                                    fontSize: 14,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 23),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Subtotal',
                                        style: manRopeSemiBold.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Service fee',
                                        style: manRopeSemiBold.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '25.00p',
                                        style: manRopeSemiBold.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '10.00p',
                                        style: manRopeSemiBold.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            width: Get.width,
                            height: 1,
                            color: whiteColor,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: manRopeSemiBold.copyWith(fontSize: 14),
                              ),
                              Text(
                                '35.00p',
                                style: manRopeSemiBold.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Number',
                          style: manRopeSemiBold.copyWith(fontSize: 12),
                        ),
                        SizedBox(height: 8),
                        CustomTextField(
                          controller: controller.carNumberController,
                          hintText: 'Add text',
                          keyboardType: TextInputType.number,
                          validator: (p0) => isCardNameValid(p0),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Expiry',
                                    style: manRopeSemiBold.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  CustomTextField(
                                    controller: controller.expiryController,
                                    hintText: 'MM-YYYY',
                                    keyboardType: TextInputType.datetime,
                                    validator: (p0) => isExpiryValid(p0),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'CVV',
                                    style: manRopeSemiBold.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  CustomTextField(
                                    controller: controller.cvvController,
                                    hintText: 'CVV',
                                    keyboardType: TextInputType.number,
                                    validator: (p0) => isCvvValid(p0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Card Holder',
                          style: manRopeSemiBold.copyWith(fontSize: 12),
                        ),
                        SizedBox(height: 8),
                        CustomTextField(
                          controller: controller.cardHolderNameController,
                          hintText: 'Add text',
                          keyboardType: TextInputType.name,
                          validator: (p0) => isCardValid(p0),
                        ),
                        SizedBox(height: Get.height * 0.1),
                        Center(
                          child: CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                playlistSentBottomSheet();
                              }
                            },
                            text: 'Pay Now',
                          ),
                        ),
                        SizedBox(height: 24),
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
