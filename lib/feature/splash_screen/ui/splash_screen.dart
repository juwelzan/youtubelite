import 'package:flutter/material.dart';
import 'package:youtubelite/feature/home/ui/youtube_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _animation = Tween<double>(begin: 0.0, end: 250.0).animate(_controller);
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status.isCompleted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => YoutubeHome()),
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0F0F0F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 65,
              width: 100,
              decoration: BoxDecoration(
                color: Color(0xffFF0000),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  Icons.play_arrow,
                  size: 50,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            SizedBox(height: 50),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  height: 10,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 10,
                    width: _animation.value,
                    decoration: BoxDecoration(
                      color: Color(0xffFF0000),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}
