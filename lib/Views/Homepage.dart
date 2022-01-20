import 'package:flutter/material.dart';
import 'package:foodybuddy/Helpers/Middle.dart';
import 'package:foodybuddy/Helpers/NavBar.dart';
import 'package:foodybuddy/Helpers/Header.dart';

class Homescreen extends StatefulWidget {
  @override
  HomescreenState createState() => HomescreenState();
}

class HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfcfcfcfc),
        bottomNavigationBar: NavBar().BottomNavigationBar(context),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header().appBar(context),
              SizedBox(
                height: 10.0,
              ),
              MiddleHelpers().textCat(),
              MiddleHelpers().dataCat(context, 'Catogories'),
              MiddleHelpers().textPopular(),
              MiddleHelpers().dataPopular(context, 'Popular Items')
            ],
          ),
        ));
  }
}
