import 'package:assessment_test_beep/constants.dart';
import 'package:flutter/material.dart';

Widget loadingIndicatorWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "Loading...",
          style: TextStyle(
            color: Constants.kGreyColor,
          ),
        ),
        SizedBox(height: 20),
        CircularProgressIndicator(
          color: Constants.kGreyColor,
        ),
      ],
    ),
  );
}
