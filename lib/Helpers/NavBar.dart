// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class NavBar extends ChangeNotifier {
  Widget BottomNavigationBar(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      margin: new EdgeInsets.all(0),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.home_outlined)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.notifications_outlined)),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.account_circle_outlined))
          ],
        ),
      ),
    );
  }
}
