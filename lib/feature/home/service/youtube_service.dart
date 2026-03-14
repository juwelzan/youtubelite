import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtubelite/feature/home/provider/youtube_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class YoutubeService {
  YoutubeService() {
    init();
  }
  late WebViewController controller;

  void init() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            final context = navigatorKey.currentContext;
            if (context != null) {
              context.read<YoutubeProvider>().isLoadingUpdate(true);
              context.read<YoutubeProvider>().progressUpdate(0);
              context.read<YoutubeProvider>().isNatworkUpdate(false);
            }
          },

          onProgress: (progress) {
            final context = navigatorKey.currentContext;
            if (context != null) {
              context.read<YoutubeProvider>().progressUpdate(progress / 100);
            }
          },
          onPageFinished: (url) async {
            final context = navigatorKey.currentContext;

            if (context != null) {
              context.read<YoutubeProvider>().isLoadingUpdate(false);
            }

            await controller.runJavaScript("""
function fixBar() {
  // পুরোনো কোড
  let pivot = document.querySelector('ytm-pivot-bar-renderer');
  if(pivot){ pivot.remove(); }

  let header = document.querySelector('ytm-mobile-topbar-renderer');
  if(header){ header.style.display = "none"; }

  let shortsHeader = document.querySelector('ytm-reel-header-renderer');
  if(shortsHeader){ shortsHeader.remove(); }

  // নতুন কোড - সব ইনপুট ডিসেবল করা
  document.querySelectorAll('input, textarea, [contenteditable=true]').forEach(el => {
    el.disabled = true; // input field disable
    el.setAttribute('readonly', 'true'); // read-only করে দাও
  });
}

fixBar();
setInterval(fixBar, 1000);
""");
          },
          onWebResourceError: (error) {
            final context = navigatorKey.currentContext;
            if (context != null) {
              context.read<YoutubeProvider>().isLoadingUpdate(false);
              context.read<YoutubeProvider>().isNatworkUpdate(true);
            }
            YoutubeProvider().isLoadingUpdate(false);
            YoutubeProvider().isNatworkUpdate(true);
          },
          onNavigationRequest: (request) {
            final uri = Uri.parse(request.url);
            final allowed = [
              'youtube.com',
              'youtu.be',
              'googlevideo.com',
              'ytimg.com',
              'accounts.google.com',
              'google.com',
            ];
            if (allowed.any((d) => uri.host.contains(d))) {
              return NavigationDecision.navigate;
            }
            // Block external links
            return NavigationDecision.prevent;
          },
        ),
      )
      ..setUserAgent(
        'Mozilla/5.0 (Linux; Android 15; Pixel 7) '
        'AppleWebKit/537.36 (KHTML, like Gecko) '
        'Chrome/121.0.0.0 Mobile Safari/537.36',
      )
      ..loadRequest(Uri.parse("https://m.youtube.com"));
  }
}
