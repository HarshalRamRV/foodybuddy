import 'package:flutter/material.dart';
import 'package:foodybuddy/Views/Homepage.dart';
import 'package:foodybuddy/Views/Account.dart';
import 'package:foodybuddy/Views/Notifications.dart';
import 'package:foodybuddy/Views/Cart.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({Key? key}) : super(key: key);

  @override
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  PageController pageController = new PageController();
  int currentIndex = 0;

  void onTap(int page) {
    setState(() {
      currentIndex = page;
    });
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        controller: pageController,
        children: [Homescreen(), Cart(), Notifications(), Account()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: onTap,
        selectedIconTheme: IconThemeData(color: Color(0xffF06623)),
        iconSize: 26.0,
        unselectedIconTheme: IconThemeData(color: Colors.grey[350]),
        fixedColor: Color(0xffF06623),
        unselectedLabelStyle: TextStyle(color: Colors.grey[300]),
        selectedFontSize: 12.5,
        unselectedFontSize: 12.0,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_sharp), title: Text('Cart')),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), title: Text('Notifications')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('Account')),
        ],
      ),
    );
  }
}
