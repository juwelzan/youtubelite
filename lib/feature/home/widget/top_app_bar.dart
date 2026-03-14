import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtubelite/core/constants/icons_path.dart';
import 'package:youtubelite/core/constants/urls.dart';
import 'package:youtubelite/core/di/dependency_injection.dart';
import 'package:youtubelite/feature/home/service/youtube_service.dart';
import 'package:youtubelite/feature/home/widget/search_dialog.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  TopAppBar({super.key});

  final YoutubeService getit = sl<YoutubeService>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff0F0F0F),
      leading: Padding(
        padding: EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Container(
              height: 35,
              width: 50,
              decoration: BoxDecoration(
                color: Color(0xffFF0000),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(Icons.play_arrow, color: Color(0xffffffff)),
              ),
            ),
            SizedBox(width: 4),
            Text(
              "YouTube",
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 22,
                fontWeight: .bold,
              ),
            ),
          ],
        ),
      ),
      actions: [
        SvgPicture.asset(IconsPath.bell, color: Color(0xffffffff), width: 30),
        SizedBox(width: 30),
        GestureDetector(
          onTap: () => showSearchDialog(context),
          child: SvgPicture.asset(
            IconsPath.search,
            color: Color(0xffffffff),
            width: 30,
          ),
        ),
        SizedBox(width: 30),
        GestureDetector(
          onTap: () {
            getit.controller.loadRequest(Urls.you);
          },
          child: SvgPicture.asset(
            IconsPath.userSolid,
            color: Color(0xffffffff),
            width: 30,
          ),
        ),
        SizedBox(width: 10),
      ],
      leadingWidth: 180,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
