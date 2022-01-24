import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodybuddy/Helpers/Middle.dart';
import 'package:foodybuddy/Views/Cart.dart';
import 'package:foodybuddy/Views/Mainpage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:foodybuddy/Views/Homepage.dart';

class DetailedScreen extends StatefulWidget {
  final QueryDocumentSnapshot queryDocumentSnapshot;
  DetailedScreen({required this.queryDocumentSnapshot});

  @override
  _DetailedScreenState createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  int totalItems = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatinActionButton(),
      backgroundColor: Color(0xfcfcfcfc),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Color(0xffF06623)),
            onPressed: () => Navigator.pop(
                  context,
                )),
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
      SizedBox(
        height: 20.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 300.0),
            child: Text(
              widget.queryDocumentSnapshot['name'],
              style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Row(
            children: [
              Icon(
                FontAwesomeIcons.rupeeSign,
                size: 20,
                color: Colors.black,
              ),
              Text(widget.queryDocumentSnapshot['price'].toString(),
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.black))
            ],
          )
        ],
      )
    ]);
  }

  Widget floatinActionButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )),
            backgroundColor: MaterialStateProperty.all(Color(0xFFF06623)),
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0)),
            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))),
        onPressed: () {},
        child: Text(
          "Add to cart",
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      Stack(children: [
        FloatingActionButton(
          backgroundColor: Color(0xFFF06623),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                  child: Cart(),
                  type: PageTransitionType.fade,
                ));
          },
          child: Icon(Icons.shopping_cart),
        ),
        Positioned(
          left: 35,
          child: CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.deepOrange[900],
            child: Text(
              '$totalItems',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ])
    ]);
  }
}
