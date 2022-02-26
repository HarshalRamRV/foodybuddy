import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodybuddy/Providers/Calculations.dart';
import 'package:foodybuddy/Views/Cart.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

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
    print(
      Provider.of<Calculations>(context, listen: false).getCartData.toString(),
    );
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
      FloatingActionButton(
          child: Icon(Icons.remove),
          backgroundColor: Color(0xFFF06623),
          onPressed: () {
            Provider.of<Calculations>(context, listen: false).minusItemQuant();
            Provider.of<Calculations>(context, listen: false)
                .removeFromCart(context, {
              'image': widget.queryDocumentSnapshot['image'],
              'name': widget.queryDocumentSnapshot['name'],
              'price': widget.queryDocumentSnapshot['price'],
              'category': widget.queryDocumentSnapshot['category'],
            });
          }),
      Card(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "0",
            // widget.queryDocumentSnapshot['quantity'].toString() == ""
            // ? '0'
            // : widget.queryDocumentSnapshot['quantity'].toString(),
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
      FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color(0xFFF06623),
          onPressed: () {
            Provider.of<Calculations>(context, listen: false).addItemQuant();
            Provider.of<Calculations>(context, listen: false)
                .addToCart(context, {
              'image': widget.queryDocumentSnapshot['image'],
              'name': widget.queryDocumentSnapshot['name'],
              'price': widget.queryDocumentSnapshot['price'],
              'category': widget.queryDocumentSnapshot['category'],
              'quantity': Provider.of<Calculations>(context, listen: false)
                  .getItemQuant,
            });
          }),
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
              Provider.of<Calculations>(context, listen: true)
                  .getCartData
                  .toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ])
    ]);
  }
}
