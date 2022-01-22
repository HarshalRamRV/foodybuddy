import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodybuddy/Views/SplashScreen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:foodybuddy/Views/Homepage.dart';
import 'package:foodybuddy/Views/Detailedpage.dart';
import 'Helpers/Header.dart';
import 'Helpers/NavBar.dart';
import 'Helpers/Middle.dart';
import 'Services/ManageData.dart';
import 'Views/Detailedpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //     apiKey: "AIzaSyABXY4KGT6NsFj5q_IJzqNKvCJZUWnCslI",
      //     authDomain: "foodybuddy-51183.firebaseapp.com",
      //     projectId: "foodybuddy-51183",
      //     storageBucket: "foodybuddy-51183.appspot.com",
      //     messagingSenderId: "724651269084",
      //     appId: "1:724651269084:web:42cd9aa100ae14b5530d19" // Your projectId
      //     ),
      );

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
      child: GetMaterialApp(
          routes: {
            '/home': (context) => Homescreen(),
            '/splash': (context) => SplashScreen(),
          },
          title: 'FoodyBuddy',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen()),
    );
  }
}
