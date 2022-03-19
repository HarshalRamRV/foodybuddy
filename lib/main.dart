import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodybuddy/Providers/Calculations.dart';
import 'package:foodybuddy/Providers/auth_provider.dart';
import 'package:foodybuddy/Providers/PaymentHelper.dart';
import 'package:foodybuddy/Providers/orderProvider.dart';
import 'package:foodybuddy/Providers/reviewCart.dart';
import 'package:foodybuddy/Views/Mainpage.dart';
import 'package:foodybuddy/Views/SplashScreen.dart';
import 'package:foodybuddy/Views/auth_screen.dart';
import 'package:foodybuddy/Views/verify_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'Helpers/Header.dart';
import 'Helpers/NavBar.dart';
import 'Helpers/Middle.dart';
import 'Services/ManageData.dart';

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
        //                 ChangeNotifierProvider<OrderProvider>(
        //   create: (context) => OrderProvider(),
        // ),
        //         ChangeNotifierProvider<ReviewCartProvider>(
        //   create: (context) => ReviewCartProvider(),
        // ),
        ChangeNotifierProvider.value(value: OrderProvider()),
        ChangeNotifierProvider.value(value: ReviewCartProvider()),
        ChangeNotifierProvider.value(value: PaymentHelper()),
        ChangeNotifierProvider.value(value: Calculations()),
        ChangeNotifierProvider.value(value: Header()),
        ChangeNotifierProvider.value(value: MiddleHelpers()),
        ChangeNotifierProvider.value(value: ManageData()),
        ChangeNotifierProvider.value(value: NavBar()),
        ChangeNotifierProvider.value(value: AuthProvider()),
      ],
      child: GetMaterialApp(
        title: 'FoodyBuddy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
              primaryColor:  Color(0xFFF06623),
  //             splashColor: Color(0xFFF06623),
  //             hintColor:Color(0xFFF06623),
  //             focusColor: Color(0xFFF06623),
  //             highlightColor: Color(0xFFF06623),
  //             textSelectionColor: Color(0xFFF06623),
  //             textSelectionHandleColor:Color(0xFFF06623),
  //             accentColor:Color(0xFFF06623),
  //              primaryColorDark:Color(0xFFF06623),
  //  hoverColor:Color(0xFFF06623),
  //  shadowColor:Color(0xFFF06623),
  //  canvasColor:Color(0xFFF06623),
  //  scaffoldBackgroundColor:Color(0xFFF06623),
  //  bottomAppBarColor:Color(0xFFF06623),
  //  cardColor:Color(0xFFF06623),
  //  dividerColor:Color(0xFFF06623),
  //  selectedRowColor:Color(0xFFF06623),
  //  unselectedWidgetColor:Color(0xFFF06623),
  //  disabledColor:Color(0xFFF06623),
        ),
        home: SplashScreen(),
        routes: {
          VerifyScreen.routeArgs: (ctx) => VerifyScreen(),
          Mainscreen.routeArgs: (ctx) => Mainscreen(),
          AuthScreen.routeArgs: (ctx) => AuthScreen()
        },
      ),
    );
  }
}
