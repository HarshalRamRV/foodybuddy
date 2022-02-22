import 'package:flutter/material.dart';
import 'package:foodybuddy/Helpers/Middle.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatinActionButton(),
      backgroundColor: Color(0xfcfcfcfc),
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Color(0xFFF06623),
        backgroundColor: Colors.white,
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [MiddleHelpers().dataCartTest(context, 'Popular Items')],
      ),
    );
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
                EdgeInsets.symmetric(horizontal: 107.0, vertical: 15.0)),
            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))),
        onPressed: () {},
        child: Text(
          "Checkout",
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      Stack(children: [
        FloatingActionButton(
          backgroundColor: Color(0xFFF06623),
          onPressed: () {},
          child: Icon(
            Icons.account_balance_wallet,
            size: 28.0,
          ),
        ),
      ])
    ]);
  }
}
