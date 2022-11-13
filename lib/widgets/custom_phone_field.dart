// ignore_for_file: prefer_const_constructors

import 'package:assessment_test_beep/provider/local.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../size_config.dart';

class CustomPhoneField extends StatelessWidget {
  final String icon;
  final TextEditingController controller;
  final Function onChanged;
  final Function onSaved;
  final Function validator;
  const CustomPhoneField({
    Key? key,
    required this.icon,
    required this.controller,
    required this.onChanged,
    required this.onSaved,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //* For checking Localization text
    var locale = AppLocalizations.of(context);
    var localeProvider = Provider.of<LocaleProvider>(context);
    bool isEnglish = localeProvider.locale!.languageCode == "en";
    return Container(
      height: getProportionateScreenHeight(70),
      width: getProportionateScreenWidth(390),
      decoration: BoxDecoration(
        color: Color(0xFF4945DB),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: Color(0xFF6E6BF3),
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Container(
            width: getProportionateScreenWidth(58),
            height: getProportionateScreenHeight(70),
            decoration: BoxDecoration(
              color: Constants.kgreenColor,
              borderRadius: localeProvider.locale!.languageCode == "en"
                  ? BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
            ),
            child: Center(
              child: SizedBox(
                width: getProportionateScreenWidth(30),
                height: getProportionateScreenHeight(30),
                child: SvgPicture.asset(
                  icon,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(10),
                right: getProportionateScreenWidth(10),
              ),
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.phone,
                onSaved: (val) => onSaved(val),
                onChanged: (val) => onChanged(val),
                validator: (val) => validator(val),
                style: TextStyle(
                  color: Constants.kGreyColor,
                  fontSize: getProportionateScreenWidth(15),
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  labelText: isEnglish ? "+966 (0)" : "(0) 966+",
                  labelStyle: TextStyle(
                    color: Constants.kGreyColor,
                    fontSize: getProportionateScreenWidth(15),
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
