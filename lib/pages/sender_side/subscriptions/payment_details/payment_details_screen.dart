
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/widgets/custom_app_bar.dart';
import 'package:musit/widgets/custom_button.dart';
import '../../../../utils/validators.dart';
import '../../../../widgets/custom_text_field.dart';
import 'controller/payment_details_controller.dart';

class PaymentDetailsScreen extends StatelessWidget {
  PaymentDetailsScreen({super.key, this.confirmOnTap});
  final controller = Get.put(PaymentDetailsController());
  final formKey = GlobalKey<FormState>();
  final void Function()? confirmOnTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          CustomAppBar(text: 'Payment Details',isBack: true,),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card Number',
                      style: manRopeSemiBold.copyWith(
                        fontSize: 12,
                      ),
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
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
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
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
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
                      style: manRopeSemiBold.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      controller: controller.cardHolderNameController,
                      hintText: 'Add text',
                      keyboardType: TextInputType.name,
                      validator: (p0) => isCardValid(p0),
                    ),
                    SizedBox(height: Get.height*0.4,),
                    Center(
                      child: CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (confirmOnTap != null) {
                              confirmOnTap!();
                            }
                            else
                              Get.back();
                          }
                        },
                        text: 'Pay Now',
                      ),
                    ),
                    SizedBox(height: 24,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}






