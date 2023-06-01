// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodybuddy/Providers/auth_provider.dart';
import 'package:foodybuddy/Views/Mainpage.dart';
import 'package:foodybuddy/widgets/rounded_button.dart';
import 'package:foodybuddy/widgets/user_text_field.dart';
import 'package:provider/provider.dart';

class VerifyScreen extends StatelessWidget {
  static const routeArgs = '/verify-screen';
  final controller = TextEditingController();

  showSnackBar(msg, color, context) {
    ScaffoldMessenger.of(context).showSnackBar(
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
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK!'),
          )
        ],
      ),
    );
  }

  verifyOTP(BuildContext context) {
    try {
      Provider.of<AuthProvider>(context, listen: false)
          .verifyOTP(controller.text.toString())
          .then((_) {
        Navigator.of(context).pushReplacementNamed(Mainscreen.routeArgs);
      }).catchError((e) {
        String errorMsg = 'Cant authentiate you Right now, Try again later!';
        if (e.toString().contains("ERROR_SESSION_EXPIRED")) {
          errorMsg = "Session expired, please resend OTP!";
        } else if (e.toString().contains("ERROR_INVALID_VERIFICATION_CODE")) {
          errorMsg = "You have entered wrong OTP!";
        }
        _showErrorDialog(context, errorMsg);
      });
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
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
                  height: 60.0,
                ),
                SizedBox(
                  height: 80.0,
                ),
                UserTextField(
                  titleLabel: 'Enter 6 digit Code',
                  maxLength: 6,
                  controller: controller,
                  inputType: TextInputType.phone, icon: null,
                ),
                SizedBox(
                  height: 40.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: RoundedButton(
                    title: 'Verify Code',
                    onPressed: () {
                      verifyOTP(context);
                    }, maxwidth: double.parse('1000'), minwidth: double.parse('400'),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Please enter code sent to your number',
                      style: TextStyle(color: Colors.grey, fontSize: 18.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
