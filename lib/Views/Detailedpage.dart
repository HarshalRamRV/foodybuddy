import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodybuddy/Helpers/Middle.dart';
import 'package:page_transition/page_transition.dart';
import 'package:foodybuddy/Views/Homepage.dart';

class DetailedScreen extends StatefulWidget {
  final QueryDocumentSnapshot queryDocumentSnapshot;
  DetailedScreen({required this.queryDocumentSnapshot});

  @override
  _DetailedScreenState createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfcfcfcfc),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Color(0xffF06623)),
          onPressed: () => Navigator.pushReplacement(
              context,
              PageTransition(
                  child: Homescreen(), type: PageTransitionType.topToBottom)),
        ),
        centerTitle: true,
        title: Text(
          widget.queryDocumentSnapshot['name'],
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [foodImage(), middleData()],
      ),
    );
  }

  // Widget appbar() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [IconButton(onPressed: () {
  //       Navi
  //     }, icon: icon)],
  //   );
  // }

  Widget foodImage() {
    return Container(
      child: SizedBox(
        child: Image.network(
          widget.queryDocumentSnapshot['image'],
          width: 415.0,
          height: 300.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget middleData() {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 300.0),
            child: Text(
              widget.queryDocumentSnapshot['name'],
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.rupeeSign,
                size: 20,
                color: Colors.orange,
              ),
              Text(widget.queryDocumentSnapshot['price'].toString(),
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))
            ],
          )
        ],
      )
    ]);
  }
}
