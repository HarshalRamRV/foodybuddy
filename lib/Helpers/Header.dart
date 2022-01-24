import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends ChangeNotifier {
  Widget appBar(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      margin: new EdgeInsets.all(0),
      elevation: 2,
      color: Colors.white,
      child: Column(
        children: [
          Image.asset(
            'assets/BFoodyBuddyLogo.png',
          ),
        ],
      ),
    );
  }
}
