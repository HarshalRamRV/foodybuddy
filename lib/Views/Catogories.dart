// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodybuddy/Helpers/Middle.dart';
import 'package:foodybuddy/Helpers/Header.dart';

class Catogories extends StatefulWidget {
  final String category;
  Catogories({required this.category});
  @override
  CatogoriesState createState() => CatogoriesState();
}

class CatogoriesState extends State<Catogories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfcfcfcfc),
      appBar: AppBar(
                foregroundColor: Color(0xFFF06623),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.category,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.0,
            ),
            MiddleHelpers().getcatpage(context, 'MainMenu', widget.category)
          ],
        ),
      ),
    );
  }
}
