import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

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
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200.0,
              width: 400.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'username',
                    style: TextStyle(color: Colors.orange, fontSize: 24.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(EvaIcons.google, color: Colors.orange),
                        Text(
                          'email Id',
                          style:
                              TextStyle(color: Colors.orange, fontSize: 20.0),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Account Settings',
              style: TextStyle(color: Colors.grey, fontSize: 14.0),
            ),
            ListTile(
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              title: Text(
                'Change Phone No',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
            ListTile(
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              title: Text(
                'Reset password',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
            ListTile(
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              title: Text(
                'Add a payment method',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
            ListTile(
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              title: Text(
                'Push notification',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
            ListTile(
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              title: Text(
                'Dark mode',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
            Text(
              'More',
              style: TextStyle(color: Colors.grey, fontSize: 14.0),
            ),
            ListTile(
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              title: Text(
                'About us',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
            ListTile(
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              title: Text(
                'Privacy policy',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
            ListTile(
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              title: Text(
                'Terms and conditions',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
