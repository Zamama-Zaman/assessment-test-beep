// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:assessment_test_beep/globel_models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../constants.dart';

class LoginController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  //* Login with email and password
  //* Here context parameter is use for to konow on which screen toast message will show
  Future<bool> loginWithEmailAndPassword(
      String email, String password, context) async {
    try {
      isLoading.value = true;
      UserCredential _user = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ignore: unnecessary_null_comparison
      if (_user != null) {
        userGlobal = UserModel(
          email: email,
          password: password,
          userId: firebaseAuth.currentUser!.uid,
        );
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        MotionToast.error(
          description: Text("Invalid email"),
          title: Text(
            "Something went wrong",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ).show(context);
      } else if (e.code == "wrong-password") {
        MotionToast.error(
          description: Text("Invalid password"),
          title: Text(
            "Something went wrong",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ).show(context);
      } else {
        MotionToast.error(
          description: Text(e.message.toString()),
          title: Text(
            "Something went wrong",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ).show(context);
      }
      isLoading.value = false;
      return false;
    } on SocketException catch (e) {
      MotionToast.error(
        description: Text(e.message.toString()),
        title: Text(
          "Something went wrong",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ).show(context);
      isLoading.value = false;
      return false;
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
      isLoading.value = false;
      return false;
    }
  }

  //* Get userId which is currently login
  Future<String> getCurrentUserId() async {
    return firebaseAuth.currentUser!.uid;
  }

  //* Get current User form firebase
  Future<UserModel?> getUserFromFirebase(context) async {
    try {
      String userId = await getCurrentUserId();
      DocumentSnapshot snapshot =
          await firestore.collection(FirebaseConst.users).doc(userId).get();
      isLoading.value = false;
      return UserModel.fromSnapshot(snapshot);
    } on SocketException catch (e) {
      MotionToast.error(
        description: Text(e.message.toString()),
        title: Text(
          "Something went wrong",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ).show(context);
      isLoading.value = false;
      return null;
    } catch (e) {
      isLoading.value = false;
      return null;
    }
  }

  //* For phone verification sending otp request to firebase
  Future<bool> phoneVerificationFirebase(String phoneNumber, context) async {
    try {
      isLoading.value = true;
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+92$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          MotionToast.error(
            description: Text(e.message.toString()),
            title: Text(
              "Something went wrong",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ).show(context);
        },
        codeSent: (String verificationId, int? resendToken) {
          verificationIdCon = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      isLoading.value = false;
      return true;
    } on SocketException catch (e) {
      MotionToast.error(
        description: Text(e.message.toString()),
        title: Text(
          "Something went wrong",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ).show(context);
      isLoading.value = false;
      return false;
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
      isLoading.value = false;
      return false;
    }
  }
}
