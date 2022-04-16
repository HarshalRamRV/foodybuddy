import 'package:flutter/material.dart';
import 'package:foodybuddy/Views/Adminpanel/AdminHomepage.dart';

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
      child = AdminHomePage();
    else if (tabItem == "Page2")
      child = AdminHomePage();
    else if (tabItem == "Page3") 
      child = AdminHomePage();
    else if (tabItem == "Page4")
      child = AdminHomePage();
    else if (tabItem == "Page5") 
      child = AdminHomePage();
      

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
