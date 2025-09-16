import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musit/pages/home/home_screen.dart';
import 'package:musit/pages/on_boarding/on_boarding_screen.dart';
import 'package:musit/pages/select_role/select_role_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MuseiT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(),
    );
  }
}
