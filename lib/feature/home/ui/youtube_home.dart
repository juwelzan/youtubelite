// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtubelite/core/di/dependency_injection.dart';
import 'package:youtubelite/feature/home/provider/youtube_provider.dart';
import 'package:youtubelite/feature/home/service/youtube_service.dart';
import 'package:youtubelite/feature/home/widget/bottom_nav.dart';
import 'package:youtubelite/feature/home/widget/no_internet_view.dart';
import 'package:youtubelite/feature/home/widget/top_app_bar.dart';

class YoutubeHome extends StatefulWidget {
  const YoutubeHome({super.key});

  @override
  State<YoutubeHome> createState() => _YoutubeHomeState();
}

class _YoutubeHomeState extends State<YoutubeHome> {
  final YoutubeService getit = sl<YoutubeService>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final canBack = await getit.controller.canGoBack();
        if (canBack) {
          await getit.controller.goBack();
          context.read<YoutubeProvider>().buttonActiveUpdate(0);
        } else {
          Navigator.pop(context);
        }
      },
      child: Consumer<YoutubeProvider>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: TopAppBar(),
            body: Stack(
              children: [
                if (value.isNetworkError)
                  NoInternetView(
                    onRetry: () async {
                      await getit.controller.reload();
                    },
                  ),
                if (!value.isNetworkError)
                  WebViewWidget(controller: getit.controller),
                if (value.isLoading)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(
                      value: value.progress == 0 ? null : value.progress,
                      minHeight: 3,
                      backgroundColor: Colors.transparent,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFFF0000),
                      ),
                    ),
                  ),
              ],
            ),

            bottomNavigationBar: value.isNetworkError ? null : BottomNav(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
