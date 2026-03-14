import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtubelite/app_config.dart';
import 'package:youtubelite/core/di/dependency_injection.dart';
import 'package:youtubelite/feature/home/provider/youtube_provider.dart';

void main() {
  DependencyInjection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => YoutubeProvider(),
      child: const AppConfig(),
    );
  }
}
