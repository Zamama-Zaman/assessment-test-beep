// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:assessment_test_beep/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import '../../size_config.dart';

class RechargeScreen extends StatelessWidget {
  const RechargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Constants.kdarkBlueColor,
      body: SafeArea(
        child: Column(
          textDirection: TextDirection.ltr,
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
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //* /// Arrow Back Button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/images/arrow_back.png",
                      width: getProportionateScreenWidth(45),
                      height: getProportionateScreenHeight(45),
                    ),
                  ),

                  //* /// Title
                  Text(
                    'Recharge',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Constants.kWhiteColor,
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  //* ///
                  SizedBox(width: SizeConfig.screenWidth * 0.05),
                ],
              ),
            ),

            //* /// Body
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
                child: SingleChildScrollView(
                  child: Column(
                    textDirection: TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: SizeConfig.screenHeight * 0.08),

                      //* /// My Balance
                      Container(
                        width: getProportionateScreenWidth(350),
                        height: getProportionateScreenHeight(185),
                        padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(130),
                        ),
                        decoration: BoxDecoration(
                          // color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage("assets/images/balance_card.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          textDirection: TextDirection.ltr,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Balance',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Constants.kWhiteColor,
                                fontSize: getProportionateScreenWidth(16),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '1280 ',
                                    style: TextStyle(
                                      color: Constants.kWhiteColor,
                                      fontSize: getProportionateScreenWidth(36),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'SAR',
                                    style: TextStyle(
                                      color: Constants.kWhiteColor,
                                      fontSize: getProportionateScreenWidth(36),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.02),
                          ],
                        ),
                      ),

                      SizedBox(height: SizeConfig.screenHeight * 0.05),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20),
                        ),
                        child: Column(
                          textDirection: TextDirection.ltr,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //* /// Enter Amount to Recharge
                            Text(
                              'Enter Amount to Recharge',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Constants.kDarkGreenShadeColor,
                                fontSize: getProportionateScreenWidth(16),
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: SizeConfig.screenHeight * 0.01),

                            //* /// Enter Amount Field
                            Container(
                              width: getProportionateScreenWidth(389),
                              height: getProportionateScreenHeight(70),
                              decoration: BoxDecoration(
                                color: Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFFE0E0E0),
                                ),
                              ),
                              child: Row(
                                textDirection: TextDirection.ltr,
                                children: [
                                  Container(
                                    width: getProportionateScreenWidth(38),
                                    height: getProportionateScreenWidth(56),
                                    margin: EdgeInsets.only(
                                      left: getProportionateScreenWidth(10),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                    ),
                                    child: Center(
                                      child: SizedBox(
                                        width: getProportionateScreenWidth(20),
                                        height:
                                            getProportionateScreenHeight(20),
                                        child: SvgPicture.asset(
                                          "assets/svg/ammount_icon.svg",
                                          color: Constants.kgreenColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        left: getProportionateScreenWidth(5.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: TextField(
                                        textDirection: TextDirection.ltr,
                                        keyboardType: TextInputType.phone,
                                        style: TextStyle(
                                          color: Constants.kGreyColor,
                                          fontSize:
                                              getProportionateScreenWidth(15),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          hintText: "0 | SAR",
                                          hintStyle: TextStyle(
                                            color: Color(0xFF9B9B9B),
                                            fontSize:
                                                getProportionateScreenWidth(15),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: SizeConfig.screenHeight * 0.02),

                            //* /// Card Holder Name Text
                            Text(
                              'Card Holder Name',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Constants.kDarkGreenShadeColor,
                                fontSize: getProportionateScreenWidth(16),
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: SizeConfig.screenHeight * 0.01),

                            //* /// Card Holder Name Field
                            Container(
                              width: getProportionateScreenWidth(389),
                              height: getProportionateScreenHeight(70),
                              decoration: BoxDecoration(
                                color: Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFFE0E0E0),
                                ),
                              ),
                              child: Row(
                                textDirection: TextDirection.ltr,
                                children: [
                                  Container(
                                    width: getProportionateScreenWidth(38),
                                    height: getProportionateScreenWidth(56),
                                    margin: EdgeInsets.only(
                                      left: getProportionateScreenWidth(10),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                    ),
                                    child: Center(
                                      child: SizedBox(
                                        width: getProportionateScreenWidth(20),
                                        height:
                                            getProportionateScreenHeight(20),
                                        child: SvgPicture.asset(
                                          "assets/svg/profile_icon_recharge.svg",
                                          color: Constants.kgreenColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        left: getProportionateScreenWidth(5.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        style: TextStyle(
                                          color: Constants.kGreyColor,
                                          fontSize:
                                              getProportionateScreenWidth(15),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textDirection: TextDirection.ltr,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          hintText: "Full Name",
                                          hintStyle: TextStyle(
                                            color: Color(0xFF9B9B9B),
                                            fontSize:
                                                getProportionateScreenWidth(15),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: SizeConfig.screenHeight * 0.02),

                            //* /// Card Number
                            Text(
                              'Card Number',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Constants.kDarkGreenShadeColor,
                                fontSize: getProportionateScreenWidth(16),
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: SizeConfig.screenHeight * 0.01),

                            //* /// Card Holder Name Field
                            Container(
                              width: getProportionateScreenWidth(389),
                              height: getProportionateScreenHeight(70),
                              decoration: BoxDecoration(
                                color: Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFFE0E0E0),
                                ),
                              ),
                              child: Row(
                                textDirection: TextDirection.ltr,
                                children: [
                                  Container(
                                    width: getProportionateScreenWidth(38),
                                    height: getProportionateScreenWidth(56),
                                    margin: EdgeInsets.only(
                                      left: getProportionateScreenWidth(10),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                    ),
                                    child: Center(
                                      child: SizedBox(
                                        width: getProportionateScreenWidth(20),
                                        height:
                                            getProportionateScreenHeight(20),
                                        child: SvgPicture.asset(
                                          "assets/svg/card_number_icon.svg",
                                          color: Constants.kgreenColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        left: getProportionateScreenWidth(5.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        style: TextStyle(
                                          color: Constants.kGreyColor,
                                          fontSize:
                                              getProportionateScreenWidth(15),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textDirection: TextDirection.ltr,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          hintText: "xxxx  xxxx  xxxx  xxxx",
                                          hintStyle: TextStyle(
                                            color: Color(0xFF9B9B9B),
                                            fontSize:
                                                getProportionateScreenWidth(15),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: SizeConfig.screenHeight * 0.02),

                            //* /// Card Number
                            Row(
                              textDirection: TextDirection.ltr,
                              children: [
                                Text(
                                  'Expiry Date',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Constants.kDarkGreenShadeColor,
                                    fontSize: getProportionateScreenWidth(16),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: SizeConfig.screenWidth * .41),
                                Text(
                                  'CVC',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Constants.kDarkGreenShadeColor,
                                    fontSize: getProportionateScreenWidth(16),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: SizeConfig.screenHeight * 0.01),

                            //* /// Expiry Date
                            Row(
                              textDirection: TextDirection.ltr,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: getProportionateScreenWidth(242),
                                  height: getProportionateScreenHeight(70),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFAFAFA),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFFE0E0E0),
                                    ),
                                  ),
                                  child: Row(
                                    textDirection: TextDirection.ltr,
                                    children: [
                                      Container(
                                        width: getProportionateScreenWidth(38),
                                        height: getProportionateScreenWidth(56),
                                        margin: EdgeInsets.only(
                                          left: getProportionateScreenWidth(10),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                          ),
                                        ),
                                        child: Center(
                                          child: SizedBox(
                                            width:
                                                getProportionateScreenWidth(20),
                                            height:
                                                getProportionateScreenHeight(
                                                    20),
                                            child: SvgPicture.asset(
                                              "assets/svg/expiry_date_icon.svg",
                                              color: Constants.kgreenColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            left: getProportionateScreenWidth(
                                                5.0),
                                          ),
                                          alignment: Alignment.center,
                                          child: TextField(
                                            keyboardType: TextInputType.phone,
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              color: Constants.kGreyColor,
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      15),
                                              fontWeight: FontWeight.w400,
                                            ),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              hintText: "MM/YY",
                                              hintStyle: TextStyle(
                                                color: Color(0xFF9B9B9B),
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        15),
                                                fontWeight: FontWeight.w400,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                ///
                                Container(
                                  width: getProportionateScreenWidth(126),
                                  height: getProportionateScreenHeight(70),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFAFAFA),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFFE0E0E0),
                                    ),
                                  ),
                                  child: Row(
                                    textDirection: TextDirection.ltr,
                                    children: [
                                      Container(
                                        width: getProportionateScreenWidth(38),
                                        height: getProportionateScreenWidth(56),
                                        margin: EdgeInsets.only(
                                          left: getProportionateScreenWidth(10),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                          ),
                                        ),
                                        child: Center(
                                          child: SizedBox(
                                            width:
                                                getProportionateScreenWidth(20),
                                            height:
                                                getProportionateScreenHeight(
                                                    20),
                                            child: SvgPicture.asset(
                                              "assets/svg/cvc_icon.svg",
                                              color: Constants.kgreenColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            left: getProportionateScreenWidth(
                                                5.0),
                                          ),
                                          alignment: Alignment.center,
                                          child: TextField(
                                            textDirection: TextDirection.ltr,
                                            keyboardType: TextInputType.phone,
                                            style: TextStyle(
                                              color: Constants.kGreyColor,
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      15),
                                              fontWeight: FontWeight.w400,
                                            ),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.zero,
                                              hintText: "xxx",
                                              hintStyle: TextStyle(
                                                color: Color(0xFF9B9B9B),
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        15),
                                                fontWeight: FontWeight.w400,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: SizeConfig.screenHeight * 0.04),
                            CustomButton(text: "Recharge"),

                            SizedBox(height: SizeConfig.screenHeight * 0.04),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
