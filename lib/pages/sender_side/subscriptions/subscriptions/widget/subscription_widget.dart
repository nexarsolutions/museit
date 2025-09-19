import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/widgets/custom_button.dart';

class SubscriptionWidget extends StatelessWidget {
  const SubscriptionWidget({
    super.key,
    required this.subscribeOnTap,
    required this.isOption1True,
    required this.isOption2True,
    required this.isOption3True,
    required this.isOption4True,
    required this.isOption5True,
    required this.planName,
    required this.price,
  });
  final void Function() subscribeOnTap;
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
            child: Column(
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
                CustomButton(onPressed: subscribeOnTap, text: 'Subscribe'),
                SizedBox(height: 24),
              ],
            ),
          ),
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
