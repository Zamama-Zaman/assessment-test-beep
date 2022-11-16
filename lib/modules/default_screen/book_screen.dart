// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kdarkBlueColor,
      body: SafeArea(
        child: Column(
          children: [
            /// App Bar
            Container(
              height: getProportionateScreenHeight(80),
              width: double.infinity,
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Book',
                    style: TextStyle(
                      color: Constants.kWhiteColor,
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            /// Body
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Constants.kGreyColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text("Book"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
