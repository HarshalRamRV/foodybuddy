// ignore_for_file: deprecated_member_use, unused_local_variable
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodybuddy/Navigation/tab_navigator.dart';
import 'package:foodybuddy/Providers/reviewCart.dart';
import 'package:foodybuddy/Views/NotificationService.dart';
import 'package:foodybuddy/Views/Notifications.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class Mainscreen extends StatefulWidget {
  static const routeArgs = '/main-screen';

  @override
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  //   String notificationTitle = 'No Title';
  // String notificationBody = 'No Body';
  // String notificationData = 'No Data';

  // @override
  // void initState() {
  //   final firebaseMessaging = FCM();
  //   firebaseMessaging.setNotifications();

  //   firebaseMessaging.streamCtlr.stream.listen(_changeData);
  //   firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
  //   firebaseMessaging.titleCtlr.stream.listen(_changeTitle);

  //   super.initState();
  // }

  // _changeData(String msg) => setState(() => notificationData = msg);
  // _changeBody(String msg) => setState(() => notificationBody = msg);
  // _changeTitle(String msg) => setState(() => notificationTitle = msg);
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    //  om message app open
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_lancher',
              ),
            ));
      }
    });
    //Message for Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new messageopen app event was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
  }


  String _currentPage = "Page1";
  List<String> pageKeys = ["Page1", "Page2", "Page3", "Page4", "Page5"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    "Page4": GlobalKey<NavigatorState>(),
    "Page5": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    return WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
          if (isFirstRouteInCurrentTab) {
            if (_currentPage != "Page1") {
              _selectTab("Page1", 1);

              return false;
            }
          }
          // let system handle back button if we're on the first route
          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          body: Stack(children: <Widget>[
            _buildOffstageNavigator("Page1"),
            _buildOffstageNavigator("Page2"),
            _buildOffstageNavigator("Page3"),
            _buildOffstageNavigator("Page4"),
            _buildOffstageNavigator("Page5"),
          ]),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            onTap: (int index) {
              _selectTab(pageKeys[index], index);
            },
            selectedIconTheme: IconThemeData(color: Color(0xffF06623)),
            iconSize: 26.0,
            unselectedIconTheme: IconThemeData(color: Colors.grey[350]),
            fixedColor: Color(0xffF06623),
            unselectedLabelStyle: TextStyle(color: Colors.grey[300]),
            selectedFontSize: 12.5,
            unselectedFontSize: 12.0,
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'Cart'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: 'Notifications'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: 'Account'),
            ],
          ),
        ));
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
