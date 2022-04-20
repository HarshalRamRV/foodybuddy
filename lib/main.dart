import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fb_business/Providers/orderProvider.dart';
import 'package:fb_business/Views/Adminpanel/AdminHomepage.dart';
import 'package:fb_business/Services/AdminDetailsHelpers.dart';
import 'package:fb_business/Providers/auth_provider.dart';
import 'package:fb_business/Views/Mainpage.dart';
import 'package:fb_business/Views/SplashScreen.dart';
import 'package:fb_business/Views/auth_screen.dart';
import 'package:fb_business/Views/verify_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //     apiKey: "AIzaSyABXY4KGT6NsFj5q_IJzqNKvCJZUWnCslI",
      //     authDomain: "fb_business-51183.firebaseapp.com",
      //     projectId: "fb_business-51183",
      //     storageBucket: "fb_business-51183.appspot.com",
      //     messagingSenderId: "724651269084",
      //     appId: "1:724651269084:web:42cd9aa100ae14b5530d19" // Your projectId
      //     ),
      );
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarBrightness: Brightness.light,
  //     statusBarIconBrightness: Brightness.dark));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: OrderProvider()),
        ChangeNotifierProvider.value(value: AdminDetailsHelpers()),
        ChangeNotifierProvider.value(value: AuthProvider()),
      ],
      child: GetMaterialApp(
        title: 'fb_business',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        routes: {
          VerifyScreen.routeArgs: (ctx) => VerifyScreen(),
          Mainscreen.routeArgs: (ctx) => Mainscreen(),
          AuthScreen.routeArgs: (ctx) => AuthScreen(),
          AdminHomePage.routeArgs: (ctx) => AdminHomePage()
        },
      ),
    );
  }
}
