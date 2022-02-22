// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:foodybuddy/Views/verify_screen.dart';
import '../widgets/user_text_field.dart';
import '../widgets/rounded_button.dart';
import '../Providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  static const routeArgs = '/auth-screen';
  final controller = TextEditingController();

  String selectedCountryCode = '+91';

  showSnackBar(msg, color, context) {
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          msg,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        duration: new Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        elevation: 3.0,
        backgroundColor: color,
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error Occured'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK!'),
          )
        ],
      ),
    );
  }

  verifyPhone(BuildContext context) {
    try {
      Provider.of<AuthProvider>(context, listen: false)
          .verifyPhone(selectedCountryCode,
              selectedCountryCode + controller.text.toString())
          .then((value) {
        Navigator.of(context).pushNamed(VerifyScreen.routeArgs);
      }).catchError((e) {
        String errorMsg = 'Cant Authenticate you, Try Again Later';
        if (e.toString().contains(
            'We have blocked all requests from this device due to unusual activity. Try again later.')) {
          errorMsg = 'Please wait as you have used limited number request';
        }
        _showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.black, fontSize: 35.0),
                      ),
                    )),
                SizedBox(
                  height: 80.0,
                ),
                UserTextField(
                  titleLabel: 'Enter your number',
                  maxLength: 10,
                  controller: controller,
                  inputType: TextInputType.phone,
                  icon: null,
                ),
                SizedBox(
                  height: 40.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: RoundedButton(
                    title: 'Send OTP',
                    onPressed: () {
                      verifyPhone(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 200.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
