import 'package:flutter/material.dart';
import 'package:musit/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/images/profile_1.png'),
              ),
              SizedBox(width: 10),
              Text('Hi, Katherine!')
            ],
          ),
        ],
      ),
    );
  }
}
