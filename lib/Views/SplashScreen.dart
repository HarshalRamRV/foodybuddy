import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodybuddy/Views/Homepage.dart';
import 'package:foodybuddy/Views/mainPage.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: Mainscreen(),
                type: PageTransitionType.leftToRightWithFade)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/startPageBG.png"),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 1, child: Image.asset('assets/AFoodyBuddyLogo.png')),
          ],
        ),
      ),
    );
  }
}
