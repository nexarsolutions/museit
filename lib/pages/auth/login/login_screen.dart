import 'package:flutter/material.dart';
import 'package:musit/constants/colors.dart';
import 'package:musit/pages/auth/widget/auth_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          AuthHeader()
        ],
      ),
    );
  }
}
