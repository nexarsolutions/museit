import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/text_styles.dart';
import '../model/notifications_model.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({super.key, required this.model});
  final NotificationsModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // ✅ Custom Borders banane ke liye Positioned widgets
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border(
                  left: BorderSide(
                    color: purpleColor,
                    width: 0.7,
                  ),

                  right: BorderSide(
                    color: purpleColor,
                    width: 0.7,
                  ),
                  bottom: BorderSide(
                    color: purpleColor,
                    width: 0.7,
                  ),
                  // top ko intentionally blank rakha
                ),
              ),
            ),
          ),

          // ✅ Content of card
          Padding(
            padding: const EdgeInsets.only(left: 6,right: 20,top: 6,bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile image
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: blackColor,
                  ),
                  child: Image.asset(model.isUnread? 'assets/images/notifications.png':'assets/images/notifications_readed.png',scale: 3.5,),
                ),

                const SizedBox(width: 12),

                // Name + Plan (left side text)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: model.isUnread?purpleColor:Colors.transparent,
                            shape: BoxShape.circle
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        model.notification,
                        style: manRope.copyWith(
                          fontSize: 12,
                          color: lightBlack,
                          fontWeight: model.isUnread? FontWeight.w800:FontWeight.w500
                        ),
                      ),
                      const SizedBox(height: 9),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          model.dateTime,
                          style: manRope.copyWith(
                              fontSize: 8,
                              color: lightBlack,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),


                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
