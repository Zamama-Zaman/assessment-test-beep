// ignore_for_file: prefer_const_constructors

import 'package:assessment_test_beep/constants.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Constants.kdarkBlueColor,
      body: SafeArea(
        child: Container(
          width: getProportionateScreenWidth(430),
          height: getProportionateScreenHeight(932),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash_screen_image.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
