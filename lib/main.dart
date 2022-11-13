// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:assessment_test_beep/all_controller_binding.dart';
import 'package:assessment_test_beep/constants.dart';
import 'package:assessment_test_beep/modules/language_screen/language_screen.dart';
import 'package:assessment_test_beep/modules/login_screen/login_controller.dart';
import 'package:assessment_test_beep/modules/splash_screen/splash_screen.dart';
import 'package:assessment_test_beep/provider/local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'l10n/l10n.dart';
import 'modules/car_screen/car_controller.dart';
import 'modules/home_screen/home_controller.dart';
import 'modules/otp_screen/otp_controller.dart';
import 'modules/sign_up_screen/sign_up_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  Get.lazyPut(() => SignUpController());
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => OtpController());
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => CarController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          return MaterialApp(
            title: 'Assessment Test Beep',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: Constants.klightBlueColor,
              backgroundColor: Constants.kdarkBlueColor,
              scaffoldBackgroundColor: Constants.kdarkBlueColor,
              fontFamily: 'Poppins',
            ),
            locale: provider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            // initialBinding: AllControllerBinding(),
            home: const LanguageScreen(),
          );
        });
  }
}
