import 'package:flutter/material.dart';
import 'package:foodybuddy/Views/Account.dart';
import 'package:foodybuddy/Views/Homepage.dart';
import 'package:foodybuddy/Views/Notifications.dart';
import 'package:foodybuddy/Views/Search.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    late Widget child;
    if (tabItem == "Page1")
      child = Homescreen();
    else if (tabItem == "Page2")
      child = Search();
    else if (tabItem == "Page3")
      child = Notifications();
    else if (tabItem == "Page4") 
      child = Account();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
