import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/widgets/custom_button.dart';

class SupportPlanWidget extends StatelessWidget {
  const SupportPlanWidget({
    super.key,
    required this.subscribeOnTap,
    required this.planName,
    required this.price, required this.subtotal, required this.serviceFee,
  });
  final void Function() subscribeOnTap;
  final String planName;
  final double price;
  final double subtotal;
  final double serviceFee;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Subtotal',style: manRopeSemiBold.copyWith(fontSize: 12),),
                        SizedBox(height: 10,),
                        Text('Service fee',style: manRopeSemiBold.copyWith(fontSize: 12),),

                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\$${subtotal.toStringAsFixed(2)}',style: manRopeSemiBold.copyWith(fontSize: 12),),
                        SizedBox(height: 10,),
                        Text('\$${serviceFee.toStringAsFixed(2)}',style: manRopeSemiBold.copyWith(fontSize: 12),),

                      ],
                    ),


                  ],
                ),
                SizedBox(height: 20),

                CustomButton(onPressed: subscribeOnTap, text: 'Subscribe'),
                SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
