import 'package:assessment_test_beep/globel_models/recharege_model.dart';
import 'package:flutter/material.dart';

import 'globel_models/user_model.dart';

class Constants {
  static const Color kdarkBlueColor = Color(0xFF3F3CC7);
  static const Color kgreenColor = Color(0xFF69B935);
  static const Color klightBlueColor = Color(0xFF18C4D8);
  static const Color kGreyColor = Color(0xFFEDEEF0);
  static const Color kDarkGreyColor = Color(0xFF9B9B9B);
  static const Color kWhiteColor = Color(0xFFFFFFFF);

  /// Delete color
  static const Color kLightRedColor = Color(0xFFFFDADA);
  static const Color kDarkRedColor = Color(0xFFDB0000);

  /// Edit color
  static const Color kLightGreenColor = Color(0xFFCFF0DD);

  static const Color kDarkGreenShadeColor = Color(0xFF113544);

  // Bottom Naviagtion Bar
  static const Color kUnselectedColor = Color(0xFF9997FC);
}

//* Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp phoneValidatorRegExp =
    RegExp(r"^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kInvalidPhoneError = "Please Enter Valid Phone no.";
const String kPhoneNullError = "Please Enter Your Phone no.";
const String kPassNullError = "Please Enter your password";
const String kOldPassNullError = "Please Enter your old password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String kAmountNullError = "Please Enter Your amount";

String verificationIdCon = "";
Map data = {};

///
const String googleAPIKey = "AIzaSyAiPQF2KnUfZpG4DOaoM9j2ouAAWd597oQ";

/// Access in any layer of project
UserModel userGlobal = UserModel();
RechargeModel rechargeModel = const RechargeModel(currentAmount: 0.0);

/// same name of every collection
class FirebaseConst {
  static const String users = "Users";
}

/// Api Key for payment
const String tapPaymentsapiKey = "sk_test_XKokBfNWv6FIYuTMg5sLPjhJ";
