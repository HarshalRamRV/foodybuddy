import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:foodybuddy/Views/SplashScreen.dart';
import 'package:foodybuddy/Views/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? get getUserPhoneNo => userPhoneNo;

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfcfcfcfc),
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Color(0xFFF06623),
        backgroundColor: Colors.white,
        title: Text(
          'Account',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: 200.0,
            //   width: 400.0,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         userPhoneNo!.substring(3).toString(),
            //         style: TextStyle(color: Colors.orange, fontSize: 24.0),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Icon(EvaIcons.google, color: Colors.orange),
            //             Text(
            //               'email Id',
            //               style:
            //                   TextStyle(color: Colors.orange, fontSize: 20.0),
            //             )
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                'Account Settings',
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
              ),
            ),
            // ListTile(
            //   trailing: Icon(
            //     Icons.arrow_forward_ios,
            //     color: Colors.black,
            //   ),
            //   title: Text(
            //     'Change Phone No',
            //     style: TextStyle(color: Colors.black, fontSize: 20.0),
            //   ),
            // ),
            // ListTile(
            //   trailing: Icon(
            //     Icons.arrow_forward_ios,
            //     color: Colors.black,
            //   ),
            //   title: Text(
            //     'Reset password',
            //     style: TextStyle(color: Colors.black, fontSize: 20.0),
            //   ),
            // ),
            // ListTile(
            //   trailing: Icon(
            //     Icons.arrow_forward_ios,
            //     color: Colors.black,
            //   ),
            //   title: Text(
            //     'Add a payment method',
            //     style: TextStyle(color: Colors.black, fontSize: 20.0),
            //   ),
            // ),
            // ListTile(
            //   trailing: Icon(
            //     Icons.arrow_forward_ios,
            //     color: Colors.black,
            //   ),
            //   title: Text(
            //     'Push notification',
            //     style: TextStyle(color: Colors.black, fontSize: 20.0),
            //   ),
            // ),
            GestureDetector(
              onTap: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.remove('uid');
                sharedPreferences.remove('phoneNumber');
                Navigator.of(context, rootNavigator: true)
                    .pushReplacementNamed(AuthScreen.routeArgs);
              },
              child: ListTile(
                trailing: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: Text(
                  'Log out',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            //   child: Text(
            //     'More',
            //     style: TextStyle(color: Colors.grey, fontSize: 14.0),
            //   ),
            // ),
            // ListTile(
            //   trailing: Icon(
            //     Icons.arrow_forward_ios,
            //     color: Colors.black,
            //   ),
            //   title: Text(
            //     'About us',
            //     style: TextStyle(color: Colors.black, fontSize: 20.0),
            //   ),
            // ),
            // ListTile(
            //   trailing: Icon(
            //     Icons.arrow_forward_ios,
            //     color: Colors.black,
            //   ),
            //   title: Text(
            //     'Privacy policy',
            //     style: TextStyle(color: Colors.black, fontSize: 20.0),
            //   ),
            // ),
            // ListTile(
            //   trailing: Icon(
            //     Icons.arrow_forward_ios,
            //     color: Colors.black,
            //   ),
            //   title: Text(
            //     'Terms and conditions',
            //     style: TextStyle(color: Colors.black, fontSize: 20.0),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
