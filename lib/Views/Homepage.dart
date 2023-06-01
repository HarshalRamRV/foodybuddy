// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodybuddy/Helpers/Middle.dart';
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
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.black,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header().appBar(context),
            SizedBox(
              height: 8.0,
            ),
            MiddleHelpers().textCat(),
            MiddleHelpers().dataCat(context, 'Catogories'),
            MiddleHelpers().textPopular(),
            MiddleHelpers().getdata(context, 'Popular Items')
          ],
        ),
      ),
    );
  }
}
