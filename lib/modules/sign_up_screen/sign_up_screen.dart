// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:assessment_test_beep/constants.dart';
import 'package:assessment_test_beep/modules/home_screen/home_screen.dart';
import 'package:assessment_test_beep/modules/otp_screen/otp_screen.dart';
import 'package:assessment_test_beep/modules/sign_up_screen/sign_up_controller.dart';
import 'package:assessment_test_beep/provider/local.dart';
import 'package:assessment_test_beep/size_config.dart';
import 'package:assessment_test_beep/widgets/custom_button.dart';
import 'package:assessment_test_beep/widgets/custom_email_field.dart';
import 'package:assessment_test_beep/widgets/custom_name_field.dart';
import 'package:assessment_test_beep/widgets/custom_password_field.dart';
import 'package:assessment_test_beep/widgets/custom_phone_field.dart';
import 'package:assessment_test_beep/widgets/form_error.dart';
import 'package:assessment_test_beep/widgets/loading_indicator_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _signUpController = Get.find<SignUpController>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _confirePasswordController;

  final List<String?> errors = [];

  //* show form errors
  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  //* show form errors
  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirePasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    //* For checking Localization text
    var locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Constants.kdarkBlueColor,
      body: Obx(
        () => _signUpController.isLoading.value
            ? loadingIndicatorWidget()
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      Container(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(10)),
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            "assets/images/arrow_back.png",
                            width: getProportionateScreenWidth(45),
                            height: getProportionateScreenHeight(45),
                          ),
                        ),
                      ),

                      //* /// Sign Up logo
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          "assets/images/sign_up_logo.png",
                          width: getProportionateScreenWidth(408),
                        ),
                      ),

                      //* /// Sign Main Image
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          "assets/images/sign_up_main_image.png",
                          width: getProportionateScreenWidth(408),
                        ),
                      ),

                      //* /// For Padding
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //* /// SignUp to Beep
                              SizedBox(height: SizeConfig.screenHeight * 0.04),
                              Row(
                                children: [
                                  Text(
                                    // 'Sign Up to ',
                                    locale!.signUpTo,
                                    style: TextStyle(
                                      color: Constants.kWhiteColor,
                                      fontSize: getProportionateScreenWidth(24),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    // 'Beep Alla Beep',
                                    locale.beepAllaBeep,
                                    style: TextStyle(
                                      color: Constants.kWhiteColor,
                                      fontSize: getProportionateScreenWidth(24),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              //* /// Please fill out
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              Text(
                                // 'Please fill out the form below to Register on \nBeep Alla Beep.',
                                locale
                                    .pleaseFillOutTheFormBelowToRegisterOnBeepAllaBeep,
                                style: TextStyle(
                                  color: Constants.kGreyColor,
                                  fontSize: getProportionateScreenWidth(16),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              //* /// Name Field
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              CustomNameField(
                                icon: "assets/svg/account_icon.svg",
                                controller: _nameController,
                                onSaved: (val) => _nameController.text = val,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    removeError(error: kNamelNullError);
                                  }
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    addError(error: kNamelNullError);
                                    return "";
                                  }
                                  return null;
                                },
                              ),

                              //* /// Email Field
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              CustomEmailField(
                                icon: "assets/svg/account_icon.svg",
                                controller: _emailController,
                                onSaved: (newValue) =>
                                    _emailController.text = newValue,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    removeError(error: kEmailNullError);
                                  }
                                  if (emailValidatorRegExp.hasMatch(value)) {
                                    removeError(error: kInvalidEmailError);
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    addError(error: kEmailNullError);
                                    return "";
                                  } else if (!emailValidatorRegExp
                                      .hasMatch(value)) {
                                    addError(error: kInvalidEmailError);
                                    return "";
                                  }
                                  return null;
                                },
                              ),

                              //* /// Phone Field
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              CustomPhoneField(
                                icon: "assets/svg/mobile_icon.svg",
                                controller: _phoneController,
                                onSaved: (newValue) =>
                                    _phoneController.text = newValue,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    removeError(error: kPhoneNullError);
                                  }
                                  if (phoneValidatorRegExp.hasMatch(value)) {
                                    removeError(error: kInvalidPhoneError);
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    addError(error: kPhoneNullError);
                                    return "";
                                  } else if (!phoneValidatorRegExp
                                      .hasMatch(value)) {
                                    addError(error: kInvalidPhoneError);
                                    return "";
                                  }
                                  return null;
                                },
                              ),

                              //* /// Password Field
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              CustomPasswordField(
                                icon: "assets/svg/lock_icon.svg",
                                text: locale.password,
                                controller: _passwordController,
                                onSaved: (newValue) =>
                                    _passwordController.text = newValue,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    removeError(error: kPassNullError);
                                  }
                                  if (value.length >= 6) {
                                    removeError(error: kShortPassError);
                                  }
                                  // _passwordController.text = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    addError(error: kPassNullError);
                                    return "";
                                  } else if (value.length < 6) {
                                    addError(error: kShortPassError);
                                    return "";
                                  }
                                  return null;
                                },
                              ),

                              //* /// Confirm Password Field
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              CustomPasswordField(
                                icon: "assets/svg/lock_icon_2.svg",
                                text: locale.confirmPassword,
                                controller: _confirePasswordController,
                                onSaved: (newValue) =>
                                    _confirePasswordController.text = newValue,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    removeError(error: kPassNullError);
                                  }
                                  if (value.isNotEmpty &&
                                      _passwordController.text ==
                                          _confirePasswordController.text) {
                                    removeError(error: kMatchPassError);
                                  }
                                  // _confirePasswordController.text = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    addError(error: kPassNullError);
                                    return "";
                                  } else if ((_passwordController.text !=
                                      value)) {
                                    addError(error: kMatchPassError);
                                    return "";
                                  }
                                  return null;
                                },
                              ),

                              //* /// Form error
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              FormError(errors: errors),

                              //* /// By signing up
                              SizedBox(height: SizeConfig.screenHeight * 0.03),
                              Row(
                                children: [
                                  Text(
                                    // 'By signing up you agree with our ',
                                    locale.bysigningUpYouAgreeWithOur,
                                    style: TextStyle(
                                      color: Constants.kGreyColor,
                                      fontSize: getProportionateScreenWidth(16),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    // 'Privacy Policy',
                                    locale.privacyPolicy,
                                    style: TextStyle(
                                      color: Constants.kgreenColor,
                                      fontSize: getProportionateScreenWidth(16),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    // 'and ',
                                    locale.and,
                                    style: TextStyle(
                                      color: Constants.kGreyColor,
                                      fontSize: getProportionateScreenWidth(16),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    // 'Terms & Conditions.',
                                    locale.termsConditions,
                                    style: TextStyle(
                                      color: Constants.kgreenColor,
                                      fontSize: getProportionateScreenWidth(16),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              //* /// Sign up Button
                              SizedBox(height: SizeConfig.screenHeight * 0.03),
                              InkWell(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      bool check;
                                      check = await _signUpController
                                          .signUpWithEmailAndPassword(
                                        _emailController.text.toString(),
                                        _passwordController.text.toString(),
                                        _phoneController.text.toString(),
                                        context,
                                      );
                                      userGlobal.name =
                                          _nameController.text.toString();
                                      if (check) {
                                        // Create User in firebase
                                        await _signUpController
                                            .createUserInFirebase(
                                          user: userGlobal,
                                        );

                                        // phone verification
                                        bool phoneCheck;

                                        phoneCheck = await _signUpController
                                            .phoneVerificationFirebase(
                                                _phoneController.text
                                                    .toString(),
                                                context);
                                        if (phoneCheck) {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => OTPScreen(
                                                  verifyId: SignUpScreen.verify,
                                                ),
                                              ),
                                              (route) => false);
                                        }
                                      }
                                    }
                                  },
                                  child: CustomButton(text: locale.signUp)),

                              //* /// Already have an account
                              SizedBox(height: SizeConfig.screenHeight * 0.04),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    // 'Already have an account? ',
                                    locale.alreadyHaveAnAccount,
                                    style: TextStyle(
                                      color: Constants.kGreyColor,
                                      fontSize: getProportionateScreenWidth(16),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    // 'Sign In',
                                    locale.signIn,
                                    style: TextStyle(
                                      color: Constants.kgreenColor,
                                      fontSize: getProportionateScreenWidth(16),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: SizeConfig.screenHeight * 0.04),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
