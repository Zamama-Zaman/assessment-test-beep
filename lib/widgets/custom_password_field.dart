// ignore_for_file: prefer_const_constructors

import 'package:assessment_test_beep/provider/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../size_config.dart';

class CustomPasswordField extends StatefulWidget {
  final String icon;
  final String text;
  final TextEditingController controller;
  final Function onChanged;
  final Function onSaved;
  final Function validator;

  const CustomPasswordField({
    Key? key,
    required this.icon,
    required this.text,
    required this.controller,
    required this.onChanged,
    required this.onSaved,
    required this.validator,
  }) : super(key: key);

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isPasswVisible = false;

  @override
  Widget build(BuildContext context) {
    var localeProvider = Provider.of<LocaleProvider>(context);
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
              borderRadius: localeProvider.locale?.languageCode == "en"
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
                  widget.icon,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(10.0),
                right: getProportionateScreenWidth(10.0),
              ),
              child: TextFormField(
                controller: widget.controller,
                obscureText: !isPasswVisible,
                keyboardType: TextInputType.name,
                onSaved: (val) => widget.onSaved(val),
                onChanged: (val) => widget.onChanged(val),
                validator: (val) => widget.validator(val),
                style: TextStyle(
                  color: Constants.kGreyColor,
                  fontSize: getProportionateScreenWidth(15),
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  labelText: widget.text,
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
          IconButton(
            splashRadius: 5.0,
            onPressed: () {
              setState(() {
                isPasswVisible = !isPasswVisible;
              });
            },
            icon: Icon(
              isPasswVisible ? Icons.visibility : Icons.visibility_off,
              color: Constants.kGreyColor,
            ),
          ),
        ],
      ),
    );
  }
}
