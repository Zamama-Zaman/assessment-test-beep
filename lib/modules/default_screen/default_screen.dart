// ignore_for_file: prefer_const_constructors

import 'package:assessment_test_beep/modules/car_screen/car_screen.dart';
import 'package:assessment_test_beep/modules/default_screen/book_screen.dart';
import 'package:assessment_test_beep/modules/default_screen/booking_screen.dart';
import 'package:assessment_test_beep/modules/default_screen/profile_screen.dart';
import 'package:assessment_test_beep/modules/home_screen/home_screen.dart';
import 'package:assessment_test_beep/provider/local.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../size_config.dart';

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({Key? key}) : super(key: key);

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen>
    with TickerProviderStateMixin {
  int currentIndex = 0;

  late AnimationController homeController,
      bookingController,
      carController,
      profileController;

  int currentPageIndex = 2;

  double sliderLeft = 0.0;
  double sliderRight = 0.0;

  bool isHomeClicked = false;
  bool isBookingClicked = false;
  bool isCarClicked = false;
  bool isProfileClicked = false;

  @override
  void initState() {
    super.initState();
    homeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    bookingController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    carController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    profileController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  List<Widget> pageIndex = [
    HomeScreen(),
    BookingScreen(),
    BookScreen(),
    CarScreen(),
    ProfileScreen(),
  ];

  @override
  void dispose() {
    super.dispose();
    homeController.dispose();
    bookingController.dispose();
    carController.dispose();
    profileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    //* For checking Localization text
    var locale = AppLocalizations.of(context);

    //*
    var localeProvider = Provider.of<LocaleProvider>(context);
    bool isEnglish = localeProvider.locale!.languageCode == "en";
    return Scaffold(
      backgroundColor: Constants.kdarkBlueColor,
      body: Stack(
        children: [
          pageIndex[currentPageIndex],
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              width: double.infinity,
              height: getProportionateScreenHeight(150),
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(
                      size.width,
                      getProportionateScreenHeight(140),
                    ),
                    painter: RPSCustomPainter(),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: SizeConfig.screenHeight * 0.015,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sliderLeft = 0.0;
                              sliderRight = 0.0;

                              currentPageIndex = 2;

                              ///
                              isHomeClicked = false;
                              homeController.reverse();
                              isBookingClicked = false;
                              bookingController.reverse();
                              isCarClicked = false;
                              carController.reverse();
                              isProfileClicked = false;
                              profileController.reverse();
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Constants.kgreenColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 8,
                                  offset: Offset(
                                    0,
                                    3,
                                  ), // changes position of shadow
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              // "Book",
                              locale!.book,
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(14),
                                fontWeight: FontWeight.w700,
                                color: Constants.kGreyColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: isEnglish ? 0 : null,
                    right: isEnglish ? null : 0,
                    child: Container(
                      height: getProportionateScreenHeight(80),
                      width: size.width * 0.37,
                      padding: EdgeInsets.only(
                        right: getProportionateScreenWidth(30),
                        left: getProportionateScreenWidth(20),
                      ),
                      // color: Colors.orange.withOpacity(.3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isEnglish
                                    ? sliderRight = 0.74
                                    : sliderRight = 0.0;
                                isEnglish
                                    ? sliderLeft = 0.0
                                    : sliderLeft = 0.69;
                                isHomeClicked = true;
                                homeController.forward();

                                currentPageIndex = 0;

                                ///
                                isBookingClicked = false;
                                bookingController.reverse();
                                isCarClicked = false;
                                carController.reverse();
                                isProfileClicked = false;
                                profileController.reverse();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(),
                              child: Column(
                                children: [
                                  AnimatedIcon(
                                    icon: AnimatedIcons.home_menu,
                                    progress: homeController,
                                    color: currentPageIndex == 0
                                        ? Constants.kWhiteColor
                                        : Constants.kUnselectedColor,
                                  ),
                                  SizedBox(
                                      height: SizeConfig.screenHeight * 0.01),
                                  Text(
                                    // "Home",
                                    locale.home,
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(11),
                                      color: currentPageIndex == 0
                                          ? Constants.kWhiteColor
                                          : Constants.kUnselectedColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isEnglish
                                    ? sliderRight = 0.42
                                    : sliderRight = 0.0;
                                isEnglish
                                    ? sliderLeft = 0.0
                                    : sliderLeft = 0.38;
                                isBookingClicked = true;
                                bookingController.forward();

                                currentPageIndex = 1;

                                ///
                                isHomeClicked = false;
                                homeController.reverse();
                                isCarClicked = false;
                                carController.reverse();
                                isProfileClicked = false;
                                profileController.reverse();
                              });
                            },
                            child: Container(
                              width: getProportionateScreenWidth(50),
                              decoration: BoxDecoration(
                                  // color: Colors.amber,
                                  ),
                              child: Column(
                                children: [
                                  AnimatedIcon(
                                    icon: AnimatedIcons.event_add,
                                    progress: bookingController,
                                    color: currentPageIndex == 1
                                        ? Constants.kWhiteColor
                                        : Constants.kUnselectedColor,
                                  ),
                                  // Icon(
                                  //   Icons.event_note,
                                  //   color: Constants.kUnselectedColor,
                                  // ),
                                  SizedBox(
                                      height: SizeConfig.screenHeight * 0.01),
                                  Text(
                                    // "Booking",
                                    locale.booking,
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(11),
                                      color: currentPageIndex == 1
                                          ? Constants.kWhiteColor
                                          : Constants.kUnselectedColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: isEnglish ? 0 : null,
                    left: isEnglish ? null : 0,
                    child: Container(
                      height: getProportionateScreenHeight(80),
                      width: size.width * 0.37,
                      padding: EdgeInsets.only(
                        right: getProportionateScreenWidth(20),
                        left: getProportionateScreenWidth(30),
                      ),
                      // color: Colors.orange.withOpacity(.3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isEnglish
                                    ? sliderRight = 0.0
                                    : sliderRight = 0.33;
                                isEnglish
                                    ? sliderLeft = 0.37
                                    : sliderLeft = 0.0;
                                isCarClicked = true;
                                carController.forward();

                                currentPageIndex = 3;

                                ///
                                isHomeClicked = false;
                                homeController.reverse();
                                isBookingClicked = false;
                                bookingController.reverse();
                                isProfileClicked = false;
                                profileController.reverse();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  // color: Colors.amber,
                                  ),
                              child: Column(
                                children: [
                                  AnimatedIcon(
                                    icon: AnimatedIcons.menu_close,
                                    progress: carController,
                                    color: currentPageIndex == 3
                                        ? Constants.kWhiteColor
                                        : Constants.kUnselectedColor,
                                  ),
                                  // Icon(
                                  //   Icons.directions_car,
                                  //   color: Constants.kGreyColor,
                                  // ),
                                  SizedBox(
                                      height: SizeConfig.screenHeight * 0.01),
                                  Text(
                                    // "Car",
                                    locale.cars,
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(11),
                                      color: currentPageIndex == 3
                                          ? Constants.kWhiteColor
                                          : Constants.kUnselectedColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                // SizeConfig.screenWidth * sliderRight, // home = 0.74 , booking = 0.42,
                                //sliderRight  profile = 0.71 , car = 0.33
                                // sliderLeft // book = 0, home = 0.69, booking = 0.38
                                //SizeConfig.screenWidth * sliderLeft, // book = 0, car = 0.37, profile = 0.73,
                                isEnglish
                                    ? sliderRight = 0.0
                                    : sliderRight = 0.71;
                                isEnglish
                                    ? sliderLeft = 0.73
                                    : sliderLeft = 0.0;
                                isProfileClicked = true;
                                profileController.forward();

                                currentPageIndex = 4;

                                ///
                                isHomeClicked = false;
                                homeController.reverse();
                                isBookingClicked = false;
                                bookingController.reverse();
                                isCarClicked = false;
                                carController.reverse();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(),
                              child: Column(
                                children: [
                                  AnimatedIcon(
                                    icon: AnimatedIcons.ellipsis_search,
                                    progress: profileController,
                                    color: currentPageIndex == 4
                                        ? Constants.kWhiteColor
                                        : Constants.kUnselectedColor,
                                  ),
                                  SizedBox(
                                      height: SizeConfig.screenHeight * 0.01),
                                  Text(
                                    // "Profile",
                                    locale.profile,
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(11),
                                      color: currentPageIndex == 4
                                          ? Constants.kWhiteColor
                                          : Constants.kUnselectedColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 900),
                    curve: Curves.easeInOutExpo,
                    bottom: 0,
                    right: SizeConfig.screenWidth *
                        sliderRight, //sliderRight  profile = 0.71 , car = 0.33
                    // SizeConfig.screenWidth * sliderRight, // home = 0.74 , booking = 0.42,
                    left: SizeConfig.screenWidth * sliderLeft,
                    // sliderLeft // book = 0, home = 0.69, booking = 0.38
                    //SizeConfig.screenWidth * sliderLeft, // book = 0, car = 0.37, profile = 0.73,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: getProportionateScreenHeight(10),
                          width: getProportionateScreenWidth(40),
                          decoration: BoxDecoration(
                            color: Constants.kgreenColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Constants.kgreenColor.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 12,
                                offset: Offset(
                                  0,
                                  -8,
                                ), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget customBottomNavigator() {
  return Container();
}

///
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Constants.kdarkBlueColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width * 0.0381625, size.height * 0.3530000);
    path0.quadraticBezierTo(size.width * 0.0008375, size.height * 0.4017000, 0,
        size.height * 0.5509000);
    path0.lineTo(0, size.height * 0.8041000);
    path0.quadraticBezierTo(size.width * 0.0005375, size.height * 0.9546000,
        size.width * 0.0377625, size.height);
    path0.cubicTo(
        size.width * 0.2747625,
        size.height * 1.0092000,
        size.width * 0.7383219,
        size.height,
        size.width * 0.9633500,
        size.height);
    path0.quadraticBezierTo(size.width * 0.9996500, size.height * 0.9539000,
        size.width, size.height * 0.7984500);
    path0.lineTo(size.width, size.height * 0.5509500);
    path0.quadraticBezierTo(size.width * 0.9996750, size.height * 0.3956500,
        size.width * 0.9624375, size.height * 0.3494000);
    path0.quadraticBezierTo(size.width * 0.8905875, size.height * 0.3493000,
        size.width * 0.6876500, size.height * 0.3505000);
    path0.quadraticBezierTo(size.width * 0.6362250, size.height * 0.3050500,
        size.width * 0.6132000, size.height * 0.2011000);
    path0.quadraticBezierTo(size.width * 0.5635375, size.height * 0.0040500,
        size.width * 0.5000000, 0);
    path0.quadraticBezierTo(size.width * 0.4383500, size.height * 0.0002500,
        size.width * 0.3887625, size.height * 0.1954500);
    path0.quadraticBezierTo(size.width * 0.3628125, size.height * 0.2993500,
        size.width * 0.3129125, size.height * 0.3538500);
    path0.quadraticBezierTo(size.width * 0.2539750, size.height * 0.3526500,
        size.width * 0.0381625, size.height * 0.3530000);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
