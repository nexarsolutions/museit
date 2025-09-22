import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musit/constants/text_styles.dart';
import 'package:musit/pages/sender_side/sender_home/sender_home/sender_home_screen.dart';
import 'package:musit/widgets/custom_bottom_sheet.dart';
import 'package:musit/widgets/custom_button.dart';

playlistSentBottomSheet(){
  return customBottomSheet(child: Column(
    children: [
      SizedBox(height: 20,),

      Text('Your MUSEiT playlist has been sent',style: manRopeSemiBold.copyWith(fontSize: 14,fontWeight: FontWeight.w700,),),
      SizedBox(height: 20,),
      Image.asset('assets/images/playlist_icon_sent.png',scale: 3.5,),
      SizedBox(height: 42,),
CustomButton(onPressed: (){
  Get.offAll(()=>SenderHomeScreen());
}, text: 'Okay')

    ],
  ));
}