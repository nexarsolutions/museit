import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: Get.height*0.12 ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/museit_icon.png',scale: 3.5,),
            SizedBox(height: 38,),
            Text('S')
          ],
        ),
      ),
    );
  }
}
