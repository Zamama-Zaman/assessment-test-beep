// ignore_for_file: prefer_const_constructors

import 'package:assessment_test_beep/modules/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../constants.dart';

class OtpController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  //* Verifying sms code with firebase verifycode
  Future<bool> checkOTPCode(String code, String verify, context) async {
    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verify,
        smsCode: code,
      );

      print(verify + "verify");
      print(code + "code");

      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
      if (auth.currentUser!.uid == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      MotionToast.error(
        description: Text(e.toString()),
        title: Text(
          "Something went wrong",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ).show(context);
      return false;
    }
  }
}
