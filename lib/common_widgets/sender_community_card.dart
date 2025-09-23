import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/common_models/saved_playlist_model.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/constants/text_styles.dart';


class SenderCommunityCard extends StatelessWidget {

   SenderCommunityCard({super.key, required this.model});
  final SavedPlaylistModel model;
  final RxBool isSaved = false.obs;

  @override
  Widget build(BuildContext context) {

    // Outer Container for the gradient border.
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // This is the gradient that acts as the border.
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFFFFF), // White at the top
            Color(0xFF561F6C), // Dark at the bottom
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      // The Padding widget creates the visible thickness of the border.
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 1, bottom: 1),
        child: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(
              16,
            ), // Outer radius (16) - Padding (2) = 14
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 121,
                      width: Get.width,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(model.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Obx(
                            () => GestureDetector(
                          onTap: () {
                            isSaved.value = !isSaved.value;
                          },
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: blackColor,
                            ),
                            child: Image.asset(
                              isSaved.value
                                  ? 'assets/images/saved_filled.png'
                                  : 'assets/images/saved_icon.png',
                              scale: 6,
                            ),
                          ),
                        ),
                      ),
                    )

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.name,
                            textAlign: TextAlign.center,
                            style: manRopeSemiBold.copyWith(fontSize: 10),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.suit_heart_fill,
                                color: blackColor,
                                size: 16,
                              ),
                              SizedBox(width: 6,),
                              Text(model.likes.toString(),style: manRope.copyWith(fontSize: 10,fontWeight: FontWeight.w200),)
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: AssetImage(model.authorProfile))
                                ),
                              ),
                              SizedBox(width: 6,),
                              Text(model.author,style: manRope.copyWith(fontSize: 8,fontWeight: FontWeight.w200),)

                            ],
                          ),

                          Text('20-05-2025',style: manRope.copyWith(fontSize: 8,fontWeight: FontWeight.w200),)
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}