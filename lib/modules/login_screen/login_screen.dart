// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:assessment_test_beep/constants.dart';
import 'package:assessment_test_beep/globel_models/user_model.dart';
import 'package:assessment_test_beep/modules/login_screen/login_controller.dart';
import 'package:assessment_test_beep/modules/login_screen/lottie_animation.dart';
import 'package:assessment_test_beep/modules/otp_screen/otp_screen.dart';
import 'package:assessment_test_beep/modules/sign_up_screen/sign_up_screen.dart';
import 'package:assessment_test_beep/provider/local.dart';
import 'package:assessment_test_beep/widgets/custom_button.dart';
import 'package:assessment_test_beep/widgets/custom_email_field.dart';
import 'package:assessment_test_beep/widgets/custom_password_field.dart';
import 'package:assessment_test_beep/widgets/custom_phone_field.dart';
import 'package:assessment_test_beep/widgets/form_error.dart';
import 'package:assessment_test_beep/widgets/loading_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswVisible = false;
  final _loginController = Get.find<LoginController>();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  //* /// Animation of Car
  ImageSequenceAnimatorState? get imageSequenceAnimator =>
      isOnline ? onlineImageSequenceAnimator : offlineImageSequenceAnimator;
  ImageSequenceAnimatorState? offlineImageSequenceAnimator;
  ImageSequenceAnimatorState? onlineImageSequenceAnimator;

  bool isOnline = false;
  bool wasPlaying = false;

  String onlineOfflineText = "Use Online";
  String loopText = "Start Loop";
  String boomerangText = "Start Boomerang";

  bool useFullPaths = false;
  List<String>? _fullPathsOffline;

  void onOfflineReadyToPlay(ImageSequenceAnimatorState _imageSequenceAnimator) {
    offlineImageSequenceAnimator = _imageSequenceAnimator;
  }

  void onOfflinePlaying(ImageSequenceAnimatorState _imageSequenceAnimator) {
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //* Screen size configration
    SizeConfig().init(context);

    //* For checking Localization text
    var locale = AppLocalizations.of(context);

    if (_fullPathsOffline == null) {
      _fullPathsOffline = [];

      for (int i = 0; i < 54; i++) {
        String _value = i.toString();
        while (_value.length < 5) _value = "0" + _value;
        _fullPathsOffline!.add("assets/gif/car_fram_images" + _value + ".gif");
      }
    }

    return Scaffold(
      backgroundColor: Constants.kdarkBlueColor,
      body: Obx(
        () => _loginController.isLoading.value
            ? loadingIndicatorWidget()
            : SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: getProportionateScreenHeight(180), //180
                          alignment: Alignment.topLeft,
                          // color: Colors.amber,
                          child: Image.asset(
                            "assets/images/logo_login.png",
                            // fit: BoxFit.fill,
                          ),
                        ),

                        //* /// main image
                        Container(
                          height: getProportionateScreenHeight(400),
                          child: Stack(
                            children: [
                              //* /// main image
                              Container(
                                color: Colors.transparent,
                                alignment: Alignment.topLeft,
                                child: Image.asset(
                                  "assets/images/login_main_image_2.png",
                                  width: getProportionateScreenWidth(400),
                                ),
                              ),

                              ///
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    bottom: getProportionateScreenHeight(20),
                                  ),
                                  height: getProportionateScreenHeight(220),
                                  child: ImageSequenceAnimator(
                                    "assets/gif/car_fram_images",
                                    "frame_",
                                    0,
                                    5,
                                    "gif",
                                    54,
                                    key: Key("offline"),
                                    fullPaths:
                                        useFullPaths ? _fullPathsOffline : null,
                                    fps: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //* /// Login to account
                        // SizedBox(height: SizeConfig.screenHeight * 0.01),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                locale!.logintoYourAccount,
                                style: TextStyle(
                                  color: Constants.kGreyColor,
                                  fontSize: getProportionateScreenWidth(23),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //* /// Phone Input Fields
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
                            } else if (!phoneValidatorRegExp.hasMatch(value)) {
                              addError(error: kInvalidPhoneError);
                              return "";
                            }
                            return null;
                          },
                        ),

                        //* /// Email Input Field
                        SizedBox(height: SizeConfig.screenHeight * 0.02),
                        CustomEmailField(
                          icon: "assets/svg/lock_icon.svg",
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
                            } else if (!emailValidatorRegExp.hasMatch(value)) {
                              addError(error: kInvalidEmailError);
                              return "";
                            }
                            return null;
                          },
                        ),

                        //* /// Password Input Field
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

                        //* /// Form error
                        SizedBox(height: SizeConfig.screenHeight * 0.02),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FormError(errors: errors),
                        ),

                        //* /// Login Button
                        SizedBox(height: SizeConfig.screenHeight * 0.02),
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              verificationIdCon = "";

                              bool check = false;
                              check = await _loginController
                                  .loginWithEmailAndPassword(
                                _emailController.text.toString(),
                                _passwordController.text.toString(),
                                context,
                              );
                              if (check) {
                                //* Assign to global accessable user
                                UserModel? user = await _loginController
                                    .getUserFromFirebase(context);
                                if (user != null) {
                                  userGlobal = user;
                                  bool checkPhone = false;
                                  checkPhone = await _loginController
                                      .phoneVerificationFirebase(
                                    _phoneController.text.toString(),
                                    context,
                                  );

                                  if (checkPhone) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OTPScreen(
                                          verifyId: LoginScreen.verify,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              }
                            }
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => OTPScreen(),
                            //   ),
                            // );
                          },
                          child: CustomButton(text: locale.login),
                        ),

                        //* /// Forgot Password
                        SizedBox(height: SizeConfig.screenHeight * 0.02),
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => LottieAnimation(),
                            //   ),
                            // );
                          },
                          child: Text(
                            locale.forgotPassword,
                            style: TextStyle(
                              color: Constants.kgreenColor,
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        //* /// Don't have an account
                        SizedBox(height: SizeConfig.screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              // 'Don’t have an account? ',
                              locale.dontHaveAnAccount,
                              style: TextStyle(
                                color: Constants.kGreyColor,
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ),
                                );

                                // final provider =
                                //     Provider.of<LocaleProvider>(context, listen: false);
                                // provider.setLocale(Locale('en'));
                              },
                              child: Text(
                                locale.signUp,
                                style: TextStyle(
                                  color: Constants.kgreenColor,
                                  fontSize: getProportionateScreenWidth(15),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        //* ///
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
