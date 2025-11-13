import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:musit/pages/auth/login/login_screen.dart';
import 'package:musit/pages/charity_side/charity_home/charity_home/charity_home_screen.dart';
import 'package:musit/pages/charity_side/charity_profile_creation/charity_profile_creation_screen.dart';
import 'package:musit/pages/recipient_side/home/recipient_home/recipient_home_screen.dart';
import 'package:musit/pages/sendBottombar/sender_bottom_bar.dart';
import 'package:musit/pages/sender_side/on_boarding/on_boarding_screen.dart';
import 'package:musit/services/deep_link_service.dart';
import 'package:musit/services/spotify_auth_service.dart';
import 'package:musit/services/user_manager.dart';

Future<void> main() async {
  // Catch all uncaught async errors in the app
  runZonedGuarded(
    () async {
      // Initialize bindings inside the same zone
      WidgetsFlutterBinding.ensureInitialized();

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      // Optional: catch Flutter framework errors
      FlutterError.onError = (FlutterErrorDetails details) {
        logger.e(
          "Flutter error caught",
          error: details.exception,
          stackTrace: details.stack,
        );
      };

      await userManager.init();
      await Get.putAsync<DeepLinkService>(() async {
        final service = DeepLinkService();
        return service.init();
      });

      await Get.putAsync(() async {
        final s = SpotifyAuthService();
        await s.checkConnection();
        return s;
      });

      // await Get.putAsync(() async {
      //   final s = YouTubeMusicAuthService();
      //   await s.checkConnection();
      //   return s;
      // });

      // Initialize the API

      // ytmusic.initialize(
      //   gl: "GB", // Force Pakistan region (works)
      //   hl: "en", // English
      //   cookies: "VISITOR_INFO1_LIVE=xyz; YSC=abc; PREF=hl=en;",
      // );

      // Start the app
      runApp(MyApp());
    },
    (error, stackTrace) {
      logger.e(
        "Uncaught async error",
        error: error,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );
    },
  );
}

// Create an instance of the YouTube Music API
// YTMusic ytmusic = YTMusic();

final Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    // number of method calls to display
    errorMethodCount: 5,
    // how much stack trace to show for errors
    lineLength: 120,
    colors: true,
    printEmojis: true,
  ),
  level: kDebugMode
      ? Level.debug
      : Level.warning, // only show detailed logs in debug
);

final userManager = UserManager();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MuseiT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: userManager.cachedUser != null
          ? userManager.cachedUser!.currentRoleId == 1
              ? SenderBottomBar()
              : userManager.cachedUser!.currentRoleId == 2
                  ? RecipientHomeScreen()
                  : userManager.cachedUser!.currentRoleId == 3
                      ? userManager.cachedUser!.charity == null
                          ? CharityProfileCreationScreen()
                          : CharityHomeScreen()
                      : LoginScreen()
          : !userManager.isFirstOpen
              ? OnBoardingScreen()
              : LoginScreen(),
    );
  }
}
