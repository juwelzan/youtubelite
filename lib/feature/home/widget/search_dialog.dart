import 'package:flutter/material.dart';
import 'package:youtubelite/core/constants/urls.dart';
import 'package:youtubelite/core/di/dependency_injection.dart';
import 'package:youtubelite/feature/home/service/youtube_service.dart';

final YoutubeService getit = sl<YoutubeService>();
void showSearchDialog(BuildContext context) {
  final controller = TextEditingController();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF212121),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            // Search bar
            TextField(
              controller: controller,
              keyboardType: TextInputType.webSearch,
              autofocus: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFFF0000)),
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onSubmitted: (query) {
                if (query.trim().isEmpty) return;
                Navigator.pop(context);
                final encoded = Uri.encodeComponent(query.trim());
                getit.controller.loadRequest(Urls.search(encoded));
              },
            ),
            const SizedBox(height: 12),

            // Quick search chips
          ],
        ),
      ),
    ),
  );
}
