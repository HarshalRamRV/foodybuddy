import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodybuddy/Views/Homepage.dart';
import 'package:lottie/lottie.dart';
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
                child: Homescreen(),
                type: PageTransitionType.leftToRightWithFade)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200.0,
              width: 400.0,
              child: Lottie.asset('animations/foodanimation.json'),
            ),
            RichText(
                text: TextSpan(
                    text: 'Foody',
                    style: TextStyle(
                        fontSize: 56.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: <TextSpan>[
                  TextSpan(
                      text: 'Buddy',
                      style: TextStyle(
                          fontSize: 56.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red))
                ]))
          ],
        ),
      ),
    );
  }
}
