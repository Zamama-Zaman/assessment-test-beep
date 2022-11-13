// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:assessment_test_beep/constants.dart';
import 'package:assessment_test_beep/modules/default_screen/default_screen.dart';
import 'package:assessment_test_beep/modules/login_screen/login_screen.dart';
import 'package:assessment_test_beep/modules/otp_screen/otp_controller.dart';
import 'package:assessment_test_beep/modules/sign_up_screen/sign_up_screen.dart';
import 'package:assessment_test_beep/provider/local.dart';
import 'package:assessment_test_beep/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class OTPScreen extends StatefulWidget {
  final String verifyId;
  const OTPScreen({
    Key? key,
    required this.verifyId,
  }) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _otpController = Get.find<OtpController>();
  String code = "";
  @override
  Widget build(BuildContext context) {
    //* Screen Size configration
    SizeConfig().init(context);

    //* For checking Localization text
    var locale = AppLocalizations.of(context);
    var localeProvider = Provider.of<LocaleProvider>(context);
    bool isEnglish = localeProvider.locale!.languageCode == "en";

    ///
    final defaultPinTheme = PinTheme(
      width: getProportionateScreenWidth(68),
      height: getProportionateScreenHeight(80),
      textStyle: TextStyle(
        color: Constants.kGreyColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF6E6BF3),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    return Scaffold(
      backgroundColor: Constants.kdarkBlueColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Container(
                padding: EdgeInsets.only(left: getProportionateScreenWidth(10)),
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

              /// OTP logo
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  "assets/images/otp_logo.png",
                  width: getProportionateScreenWidth(300),
                ),
              ),

              /// OTP Main Image
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  isEnglish
                      ? "assets/images/otp_main_image.png"
                      : "assets/images/otp_main_image_arabic.png",
                  width: getProportionateScreenWidth(430),
                ),
              ),

              /// Please enter below
              Container(
                alignment:
                    isEnglish ? Alignment.centerLeft : Alignment.centerRight,
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    Text(
                      // 'Please enter below 5 digit code that you ',
                      locale!.pleaseEnterBelowFiveDigitCodeThatYou,
                      style: TextStyle(
                        color: Constants.kWhiteColor,
                        fontSize: getProportionateScreenWidth(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      // 'received on your phone.',
                      locale.receivedOnYourPhone,
                      style: TextStyle(
                        color: Constants.kWhiteColor,
                        fontSize: getProportionateScreenWidth(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              /// Timer
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Row(
                textDirection:
                    isEnglish ? TextDirection.ltr : TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: getProportionateScreenWidth(35),
                    height: getProportionateScreenHeight(45),
                    decoration: BoxDecoration(
                      color: Constants.klightBlueColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '01',
                      style: TextStyle(
                        color: Constants.kWhiteColor,
                        fontSize: getProportionateScreenWidth(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    width: getProportionateScreenWidth(25),
                    // height: getProportionateScreenHeight(45),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      ':',
                      style: TextStyle(
                        color: Constants.kWhiteColor,
                        fontSize: getProportionateScreenWidth(16),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: getProportionateScreenWidth(35),
                    height: getProportionateScreenHeight(45),
                    decoration: BoxDecoration(
                      color: Constants.klightBlueColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '00',
                      style: TextStyle(
                        color: Constants.kWhiteColor,
                        fontSize: getProportionateScreenWidth(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),

              /// Otp Input Field
              ///
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    showCursor: true,
                    onChanged: (val) {
                      code = val;
                    },
                    onCompleted: (val) {
                      print(val);
                    },
                  ),
                ),
              ),

              /// Verification Button
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              InkWell(
                  onTap: () async {
                    bool check;
                    check = await _otpController.checkOTPCode(
                      code,
                      widget.verifyId,
                      context,
                    );
                    if (check) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DefaultScreen(),
                          ),
                          (route) => false);
                    }
                  },
                  child: CustomButton(text: locale.verify)),

              SizedBox(height: SizeConfig.screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
