import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text_styles.dart';
import '../../../../../widgets/custom_button.dart';


class RenewSubscriptionWidget extends StatelessWidget {
  const RenewSubscriptionWidget({
    super.key,
    required this.renewOnTap,
    required this.isOption1True,
    required this.isOption2True,
    required this.isOption3True,
    required this.isOption4True,
    required this.isOption5True,
    required this.planName,
    required this.price,
  });
  final void Function() renewOnTap;
  final bool isOption1True;
  final bool isOption2True;
  final bool isOption3True;
  final bool isOption4True;
  final bool isOption5True;
  final String planName;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: blackColor,
              borderRadius: BorderRadiusGeometry.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Image.asset('assets/images/dollar.png', scale: 3.2),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    planName,
                    style: manRopeSemiBold.copyWith(
                      fontSize: 14,
                      color: whiteColor,
                    ),
                  ),
                ),
                Text(
                  '\$${price.toString()}/Month',
                  style: manRopeSemiBold.copyWith(
                    fontSize: 14,
                    color: whiteColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 23),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTickRow(isChecked: isOption1True, title: 'Lorem Ipsum'),
                      SizedBox(height: 8),
                      buildTickRow(isChecked: isOption2True, title: 'Lorem Ipsum'),
                      SizedBox(height: 8),
                      buildTickRow(isChecked: isOption3True, title: 'Lorem Ipsum'),
                      SizedBox(height: 8),
                      buildTickRow(isChecked: isOption4True, title: 'Lorem Ipsum'),
                      SizedBox(height: 8),
                      buildTickRow(isChecked: isOption5True, title: 'Lorem Ipsum'),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Start Date',style: manRopeSemiBold.copyWith(fontSize: 12),),
                            SizedBox(height: 12,),
                            Text('End Date',style: manRopeSemiBold.copyWith(fontSize: 12),),

                          ],
                        ),
                        SizedBox(width: 12,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('20-05-2025',style: manRopeSemiBold.copyWith(fontSize: 10),),
                            SizedBox(height: 12,),
                            Text('19-06-2025',style: manRopeSemiBold.copyWith(fontSize: 10),),

                          ],
                        ),

                      ],
                    ),

                  ],
                )
              ],
            ),
          ),
          CustomButton(onPressed: renewOnTap, text: 'Renew'),
          SizedBox(height: 24),

        ],
      ),
    );
  }

  Widget buildTickRow({required bool isChecked, required String title}) {
    return Row(
      children: [
        Image.asset(
          isChecked
              ? 'assets/images/green_tick.png'
              : 'assets/images/grey_tick.png',
          width: 20,
          height: 20,
        ),
        const SizedBox(width: 12),
        Text(title, style: manRopeSemiBold.copyWith(fontSize: 12)),
      ],
    );
  }
}
