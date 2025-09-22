import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:password_manager/utils/app_color.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    splashingTiming();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Center(
        child: Lottie.asset("asset/splash-animation.json",height: 250),
      ),
    );
  }
  Future<void>splashingTiming()async{
    await Future.delayed(Duration(milliseconds: 2500));
    context.go("/login");
  }
}