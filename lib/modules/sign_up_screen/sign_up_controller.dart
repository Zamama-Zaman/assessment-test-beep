// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:assessment_test_beep/globel_models/user_model.dart';
import 'package:assessment_test_beep/modules/sign_up_screen/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../constants.dart';

class SignUpController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  //* SignUp with email and password
  Future<bool> signUpWithEmailAndPassword(
      String email, String password, String number, context) async {
    //* Context parameter is user for to know on which screen toast message will show
    try {
      isLoading.value = true;
      UserCredential _user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (_user != null) {
        userGlobal = UserModel(
          email: email,
          password: password,
          number: number,
          userId: firebaseAuth.currentUser!.uid,
        );
        isLoading.value = false;
        return true;
      } else {
        isLoading.value = false;
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        MotionToast.error(
          description: Text("Email is already taken"),
          title: Text(
            "Something went wrong",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ).show(context);
        isLoading.value = false;
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
        isLoading.value = false;
      }
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

  //* Creating user in firebase firestore with is currently signUp
  Future<void> createUserInFirebase({required UserModel user}) async {
    try {
      isLoading.value = true;
      CollectionReference userCollectionRef =
          firestore.collection(FirebaseConst.users);

      final String userId = await getCurrentUserId();

      userCollectionRef.doc(userId).get().then((value) {
        final newUser = UserModel(
          name: user.name,
          email: user.email,
          password: user.password,
          userId: user.userId,
        ).toDocument();
        if (!value.exists) {
          userCollectionRef.doc(userId).set(newUser);
        }
      });
      isLoading.value = false;
    } catch (e) {
      print("error $e");
      isLoading.value = false;
    }
  }

  //* Get userId which is currently login
  Future<String> getCurrentUserId() async {
    return firebaseAuth.currentUser!.uid;
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
          SignUpScreen.verify = verificationId;
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
