import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';

class ConnectAccountPrompt extends StatelessWidget {
  final String serviceName;
  final String assetPath;
  final void Function()? onPressed;

  const ConnectAccountPrompt({
    super.key,
    required this.serviceName,
    required this.assetPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height - 300,
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: blackColor,
            child: Center(child: Image.asset(assetPath, height: 20)),
          ),
          const SizedBox(height: 16),
          // Text(
          //   "Connect your $serviceName account to browse songs",
          //   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          //   textAlign: TextAlign.center,
          // ),

          Center(
            child: Text(
              "Coming Soon",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          // CustomButton(
          //   text: "Connect $serviceName",
          //   onPressed: onPressed ??
          //       () {
          //         customErrorSnackBar(content: "Coming Soon");
          //       },
          // ),
        ],
      ),
    );
  }
}
