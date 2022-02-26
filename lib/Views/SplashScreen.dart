import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodybuddy/Views/Mainpage.dart';
import 'package:foodybuddy/Views/auth_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? userUid;
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future getUid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userUid = sharedPreferences.getString('uid');
    print(userUid);
  }

  @override
  void initState() {
    getUid().whenComplete(() {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              PageTransition(
                  child: userUid == null ? AuthScreen() : Mainscreen(),
                  type: PageTransitionType.leftToRightWithFade)));

    });
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
