// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:youtubelite/core/constants/icons_path.dart';
import 'package:youtubelite/core/constants/urls.dart';
import 'package:youtubelite/core/di/dependency_injection.dart';
import 'package:youtubelite/feature/home/provider/youtube_provider.dart';
import 'package:youtubelite/feature/home/service/youtube_service.dart';

class BottomNav extends StatelessWidget {
  BottomNav({super.key});
  final YoutubeService getit = sl<YoutubeService>();
  @override
  Widget build(BuildContext context) {
    return Consumer<YoutubeProvider>(
      builder: (context, state, child) {
        return SafeArea(
          top: false,
          child: Container(
            height: 65,
            decoration: BoxDecoration(color: Color(0xff0F0F0F)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _navItem(
                    svdpath: state.buttonActive == 0
                        ? IconsPath.homeBold
                        : IconsPath.homeSolid,
                    onTap: () async {
                      await getit.controller.loadRequest(Urls.home);
                      context.read<YoutubeProvider>().buttonActiveUpdate(0);
                    },
                  ),
                  _navItem(
                    svdpath: state.buttonActive == 1
                        ? IconsPath.reelBold
                        : IconsPath.reelSolid,
                    label: "shorts",
                    onTap: () async {
                      context.read<YoutubeProvider>().buttonActiveUpdate(1);
                      await getit.controller.loadRequest(Urls.shorts);
                    },
                  ),
                  Container(
                    height: 45,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                      border: Border.all(width: 3, color: Color(0xffAAAAAA)),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        IconsPath.add,
                        width: 35,
                        color: Color(0xffAAAAAA),
                      ),
                    ),
                  ),

                  _navItem(
                    svdpath: state.buttonActive == 2
                        ? IconsPath.listBold
                        : IconsPath.listSolid,
                    label: "subscribe",
                    onTap: () async {
                      await getit.controller.loadRequest(Urls.subscribe);
                      context.read<YoutubeProvider>().buttonActiveUpdate(2);
                    },
                  ),
                  _navItem(
                    svdpath: state.buttonActive == 3
                        ? IconsPath.userBold
                        : IconsPath.userSolid,
                    label: "you",
                    onTap: () async {
                      await getit.controller.loadRequest(Urls.you);
                      context.read<YoutubeProvider>().buttonActiveUpdate(3);
                      print("object");
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _navItem({
  required String svdpath,
  required VoidCallback onTap,
  String label = "home",
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(svdpath, height: 30, color: Color(0xffAAAAAA)),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis,
            color: Color(0xffAAAAAA),
          ),
        ),
      ],
    ),
  );
}
