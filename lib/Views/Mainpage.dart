// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodybuddy/Navigation/tab_navigator.dart';

class Mainscreen extends StatefulWidget {
  static const routeArgs = '/main-screen';
  const Mainscreen({Key? key}) : super(key: key);

  @override
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  String _currentPage = "Page1";
  List<String> pageKeys = ["Page1", "Page2", "Page3", "Page4"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    "Page4": GlobalKey<NavigatorState>(),
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
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), title: Text('Search')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  title: Text('Notifications')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), title: Text('Account')),
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
