import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/custom_error_snack_bar.dart';
import '../../../../../widgets/custom_button.dart';

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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: blackColor,
            child: Center(child: Image.asset(assetPath, height: 20)),
          ),
          const SizedBox(height: 16),
          Text(
            "Connect your $serviceName account to browse songs",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: "Connect $serviceName",
            onPressed: onPressed ??
                () {
                  customErrorSnackBar(content: "Coming Soon");
                },
          ),
        ],
      ),
    );
  }
}
