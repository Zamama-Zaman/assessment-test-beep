// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:assessment_test_beep/constants.dart';
import 'package:assessment_test_beep/modules/home_screen/home_controller.dart';
import 'package:assessment_test_beep/modules/recharge_screen/recharge_screen.dart';
import 'package:assessment_test_beep/provider/local.dart';
import 'package:assessment_test_beep/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    initializeAllFunction();
  }

  initializeAllFunction() async {
    await _homeController.setCameraPosition();
    await _homeController.getUserCurrentLocation();
    await _homeController.setCurrrentCameraPosition();
    await _homeController.setFirstMarker();
    await _homeController.setMarker();
    await _homeController.currentWeather();
    await _homeController.getCityName();
  }

  @override
  Widget build(BuildContext context) {
    //* Screen size configration
    SizeConfig().init(context);
    //* For checking Localization text
    var locale = AppLocalizations.of(context);
    var localeProvider = Provider.of<LocaleProvider>(context);
    bool isEnglish = localeProvider.locale!.languageCode == "en";
    return Scaffold(
      backgroundColor: Constants.kdarkBlueColor,
      body: Obx(
        () => SafeArea(
          child: Column(
            children: [
              Container(
                height: getProportionateScreenHeight(150),
                width: double.infinity,
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      // width: getProportionateScreenWidth(60),
                      // height: getProportionateScreenHeight(80),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    SizedBox(width: SizeConfig.screenWidth * 0.02),
                    Container(
                      height: getProportionateScreenHeight(85),
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale!.hello,
                            style: TextStyle(
                              fontFamily: isEnglish ? "Poppins" : "AdobeArabic",
                              color: Constants.kWhiteColor,
                              fontSize: getProportionateScreenWidth(14),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            // 'Abdullah!',
                            locale.abdullah,
                            style: TextStyle(
                              color: Constants.kWhiteColor,
                              fontSize: getProportionateScreenWidth(17),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/current_location_icon.svg",
                                color: Color(0xFF9997FC),
                              ),
                              SizedBox(width: SizeConfig.screenWidth * 0.02),
                              Text(
                                // 'Riyadh',
                                locale.riyadh,
                                style: TextStyle(
                                  fontFamily:
                                      isEnglish ? "Poppins" : "AdobeArabic",
                                  color: Constants.kWhiteColor,
                                  fontSize:
                                      getProportionateScreenWidth(12), //12
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: getProportionateScreenHeight(120),
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RechargeScreen(),
                                ),
                              ).then((value) {
                                setState(() {});
                              });
                            },
                            child: Container(
                              width: getProportionateScreenWidth(118),
                              height: getProportionateScreenHeight(45),
                              decoration: BoxDecoration(
                                color: Constants.kgreenColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset("assets/svg/sar_icon.svg"),
                                  Row(
                                    children: [
                                      Text(
                                        '${rechargeModel.currentAmount} ',
                                        style: TextStyle(
                                          color: Constants.kWhiteColor,
                                          fontSize:
                                              getProportionateScreenWidth(16),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                          width: SizeConfig.screenWidth * 0.01),
                                      Text(
                                        locale.sAR,
                                        style: TextStyle(
                                          color: Constants.kWhiteColor,
                                          fontSize:
                                              getProportionateScreenWidth(16),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Row(
                            textDirection: isEnglish
                                ? TextDirection.ltr
                                : TextDirection.ltr,
                            children: [
                              Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: SizedBox(
                                    height: getProportionateScreenHeight(70),
                                    width: getProportionateScreenWidth(60),
                                    child: Image.asset(
                                      "assets/images/sun_image.png",
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(width: SizeConfig.screenWidth * 0.02),
                              Container(
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // "40°C",
                                      _homeController.temp.toString() + " °C",
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Constants.kWhiteColor,
                                        fontSize:
                                            getProportionateScreenWidth(24),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      // locale.riyadh,
                                      _homeController.cityName.toString(),
                                      style: isEnglish
                                          ? TextStyle(
                                              color: Color(0xFF9997FC),
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      10),
                                              fontWeight: FontWeight.w400,
                                            )
                                          : TextStyle(
                                              fontFamily: "AdobeArabic",
                                              color: Color(0xFF9997FC),
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                18, //18
                                              ),
                                              fontWeight: FontWeight.w400,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: SizeConfig.screenWidth * 0.02),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Stack(
                    children: [
                      /// Map image
                      // Container(
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //       image: AssetImage(
                      //         "assets/images/map_image.png",
                      //       ),
                      //       fit: BoxFit.cover,
                      //     ),
                      //     borderRadius: BorderRadius.only(
                      //       topLeft: Radius.circular(20),
                      //       topRight: Radius.circular(20),
                      //     ),
                      //   ),
                      // ),
                      /// Google Map
                      GoogleMap(
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        markers: _homeController.marker.toSet(),
                        initialCameraPosition:
                            _homeController.initialCameraPosition,
                        onMapCreated: (controller) =>
                            _homeController.setGoogleMapController(controller),
                      ),

                      /// pin location Icon
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: SvgPicture.asset(
                      //     "assets/svg/pin_location_icon_home.svg",
                      //   ),
                      // ),

                      /// Search Icon
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20),
                          vertical: getProportionateScreenHeight(20),
                        ),
                        child: InkWell(
                          onTap: () {
                            // _homeController.currentWeather();
                            _homeController.getCityName();
                          },
                          child: Image.asset(
                            "assets/images/search_icon.png",
                            width: getProportionateScreenWidth(45),
                            height: getProportionateScreenHeight(45),
                          ),
                        ),
                      ),

                      /// Star Icon
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(70),
                          vertical: getProportionateScreenHeight(20),
                        ),
                        child: GestureDetector(
                          onTap: null,
                          child: Image.asset(
                            "assets/images/star_icon.png",
                            width: getProportionateScreenWidth(45),
                            height: getProportionateScreenHeight(45),
                          ),
                        ),
                      ),

                      /// Orientation Image
                      Container(
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20),
                          vertical: getProportionateScreenHeight(20),
                        ),
                        child: Image.asset(
                          "assets/images/orientation_image.png",
                          width: getProportionateScreenWidth(45),
                          height: getProportionateScreenHeight(45),
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
    );
  }
}
