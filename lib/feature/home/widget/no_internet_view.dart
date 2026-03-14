import 'package:flutter/material.dart';

class NoInternetView extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetView({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.white;
    final subColor = Colors.grey[400]!;

    return ColoredBox(
      color: const Color(0xFF0F0F0F),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Error icon
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: const Color(0xFF272727),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.wifi_off_rounded,
                  size: 44,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'No internet connection.',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Check your network connection and try again.',
                style: TextStyle(color: subColor, fontSize: 14, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try again.', style: TextStyle(fontSize: 15)),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFFF0000),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
