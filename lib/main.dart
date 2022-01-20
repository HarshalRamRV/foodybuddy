import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodybuddy/Views/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'package:foodybuddy/Views/Homepage.dart';

import 'Helpers/Header.dart';
import 'Helpers/NavBar.dart';
import 'Helpers/Middle.dart';
import 'Services/ManageData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Header()),
        ChangeNotifierProvider.value(value: MiddleHelpers()),
        ChangeNotifierProvider.value(value: ManageData()),
        ChangeNotifierProvider.value(value: NavBar())
      ],
      child: MaterialApp(
          title: 'FoodyBuddy',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen()),
    );
  }
}
