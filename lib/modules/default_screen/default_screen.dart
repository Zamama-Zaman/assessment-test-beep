// ignore_for_file: prefer_const_constructors

import 'package:assessment_test_beep/modules/car_screen/car_screen.dart';
import 'package:assessment_test_beep/modules/home_screen/home_screen.dart';
import 'package:assessment_test_beep/provider/local.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../size_config.dart';

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({Key? key}) : super(key: key);

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  int currentIndex = 0;

  final screen = [
    HomeScreen(),
    Center(child: Text("Bookings")),
    Center(child: Text("Book")),
    CarScreen(),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //* For checking Localization text
    var locale = AppLocalizations.of(context);

    //*
    var localeProvider = Provider.of<LocaleProvider>(context);
    bool isEnglish = localeProvider.locale!.languageCode == "en";
    return Scaffold(
      backgroundColor: Constants.kdarkBlueColor,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Constants.kdarkBlueColor,
        selectedItemColor: Constants.kWhiteColor,
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: locale!.home,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svg/booking_icon.svg",
              color: currentIndex == 1 ? Colors.white : Color(0xFF9997FC),
            ),
            label: locale.booking,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: locale.book,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svg/car_icon.svg",
              color: currentIndex == 3 ? Colors.white : Color(0xFF9997FC),
            ),
            label: locale.cars,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/svg/profile_icon.svg",
              color: currentIndex == 4 ? Colors.white : Color(0xFF9997FC),
            ),
            label: locale.profile,
          ),
        ],
      ),
      body: screen[currentIndex],
    );
  }
}
