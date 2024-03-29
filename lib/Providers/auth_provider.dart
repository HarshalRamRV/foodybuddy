// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  late String verificationId;
  String? uid;
  String? get getUid => uid;
  String? phoneNo;
  String? get getphoneNo => phoneNo;

  Future<void> verifyPhone(String countryCode, String mobile) async {
    var mobileToSend = mobile;
    final PhoneCodeSent smsOTPSent = (String verId, [int? forceCodeResend]) {
      this.verificationId = verId;
    };

    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: mobileToSend,
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(
            seconds: 120,
          ),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException exceptio) {
            throw exceptio;
          });
    } catch (e) {
      throw e;
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      final UserCredential user =
          await _firebaseAuth.signInWithCredential(credential);
      final User? currentUser = _firebaseAuth.currentUser;

      if (currentUser!.uid != "") {
        print(currentUser.uid);
      }
      if (currentUser.phoneNumber != "") {
        print(currentUser.phoneNumber);
      }
      uid = currentUser.uid;
      phoneNo = currentUser.phoneNumber;
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('uid', uid!);
      notifyListeners();
      sharedPreferences.setString('phoneNumber', phoneNo!);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  showError(error) {
    throw error.toString();
  }
}
