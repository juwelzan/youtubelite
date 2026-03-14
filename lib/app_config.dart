import 'package:flutter/material.dart';
import 'package:youtubelite/feature/home/service/youtube_service.dart';
import 'package:youtubelite/feature/splash_screen/ui/splash_screen.dart';

class AppConfig extends StatefulWidget {
  const AppConfig({super.key});

  @override
  State<AppConfig> createState() => _AppConfigState();
}

class _AppConfigState extends State<AppConfig> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
