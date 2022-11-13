// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class CustomButton extends StatelessWidget {
  final String text;
  const CustomButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(70),
      width: getProportionateScreenWidth(390),
      decoration: BoxDecoration(
        color: Constants.kgreenColor,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: getProportionateScreenWidth(16),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
