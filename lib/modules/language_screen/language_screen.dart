// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:assessment_test_beep/constants.dart';
import 'package:assessment_test_beep/modules/login_screen/login_screen.dart';
import 'package:assessment_test_beep/provider/local.dart';
import 'package:assessment_test_beep/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool isLanguageArabic = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        width: getProportionateScreenWidth(430),
        height: getProportionateScreenHeight(932),
        color: Constants.kdarkBlueColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// Logo and center image
                Container(
                  height: getProportionateScreenHeight(480),
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          height: getProportionateScreenHeight(180),
                          width: getProportionateScreenWidth(420),
                          child: SvgPicture.asset("assets/svg/logo_svg_2.svg"),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          color: Colors.transparent,
                          width: getProportionateScreenWidth(400),
                          height: getProportionateScreenHeight(340),
                          child: SvgPicture.asset(
                            "assets/svg/center_svg.svg",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// choose your language
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                  ),
                  child: Column(
                    textDirection: TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        textDirection: TextDirection.ltr,
                        children: [
                          Text(
                            'Choose',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: getProportionateScreenWidth(24),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: SizeConfig.screenWidth * 0.47),
                          Image.asset(
                            "assets/images/ellipse_light_small.png",
                            width: 30,
                            height: 30,
                          ),
                        ],
                      ),
                      Text(
                        'Your Language',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: getProportionateScreenWidth(24),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Please choose your language
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                  ),
                  child: Text(
                    "Please choose your language below and continue to the app.",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Constants.kGreyColor,
                      fontSize: getProportionateScreenWidth(16),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                /// Language Cards
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                  ),
                  child: Row(
                    textDirection: TextDirection.ltr,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isLanguageArabic = true;
                          });
                          final provider = Provider.of<LocaleProvider>(
                            context,
                            listen: false,
                          );
                          provider.setLocale(Locale('ar'));
                        },
                        child: Stack(
                          textDirection: TextDirection.ltr,
                          children: [
                            Container(
                              height: getProportionateScreenHeight(180),
                              width: getProportionateScreenWidth(184),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: isLanguageArabic
                                    ? Color(0xFF18C4D8).withOpacity(.3)
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Color(0xFF6E6BF3),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/saudi_flag.png",
                                    width: getProportionateScreenWidth(82),
                                    height: getProportionateScreenHeight(82),
                                  ),
                                  SizedBox(
                                      height: SizeConfig.screenHeight * 0.015),
                                  Text(
                                    'عربی',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "NotoKufiArabic",
                                      color: Color(0xFFFFFFFF),
                                      fontSize: getProportionateScreenWidth(16),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: isLanguageArabic,
                              child: Padding(
                                padding: EdgeInsets.all(
                                  getProportionateScreenWidth(15),
                                ),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: SvgPicture.asset(
                                    "assets/svg/circular_blue_tick.svg",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: SizeConfig.screenWidth * 0.04),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isLanguageArabic = false;
                          });
                          final provider = Provider.of<LocaleProvider>(context,
                              listen: false);
                          provider.setLocale(
                            Locale('en'),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: getProportionateScreenHeight(180),
                              width: getProportionateScreenWidth(184),
                              decoration: BoxDecoration(
                                color: isLanguageArabic
                                    ? Colors.transparent
                                    : Color(0xFF18C4D8).withOpacity(.3),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFF6E6BF3),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/images/uk_flag_image.png",
                                    width: getProportionateScreenWidth(82),
                                    height: getProportionateScreenHeight(82),
                                  ),
                                  Text(
                                    'English',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: getProportionateScreenWidth(16),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: !isLanguageArabic,
                              child: Padding(
                                padding: EdgeInsets.all(
                                  getProportionateScreenWidth(15),
                                ),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: SvgPicture.asset(
                                    "assets/svg/circular_blue_tick.svg",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// Continue Button
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: CustomButton(text: "Continue"),
                ),

                SizedBox(height: SizeConfig.screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
