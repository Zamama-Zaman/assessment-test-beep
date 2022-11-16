// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:assessment_test_beep/constants.dart';
import 'package:assessment_test_beep/size_config.dart';
import 'package:flutter/material.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';

class LottieAnimation extends StatefulWidget {
  const LottieAnimation({Key? key}) : super(key: key);

  @override
  State<LottieAnimation> createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation> {
  // double width = getProportionateScreenWidth(357);
  // double height = getProportionateScreenHeight(200);

  ///
  ImageSequenceAnimatorState? get imageSequenceAnimator =>
      isOnline ? onlineImageSequenceAnimator : offlineImageSequenceAnimator;
  ImageSequenceAnimatorState? offlineImageSequenceAnimator;
  ImageSequenceAnimatorState? onlineImageSequenceAnimator;

  bool isOnline = false;
  bool wasPlaying = false;

  String onlineOfflineText = "Use Online";
  String loopText = "Start Loop";
  String boomerangText = "Start Boomerang";

  bool useFullPaths = false;
  List<String>? _fullPathsOffline;

  void onOfflineReadyToPlay(ImageSequenceAnimatorState _imageSequenceAnimator) {
    offlineImageSequenceAnimator = _imageSequenceAnimator;
  }

  void onOfflinePlaying(ImageSequenceAnimatorState _imageSequenceAnimator) {
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_fullPathsOffline == null) {
      _fullPathsOffline = [];

      for (int i = 0; i < 54; i++) {
        String _value = i.toString();
        while (_value.length < 5) {
          _value = "0" + _value;
        }
        _fullPathsOffline!.add("assets/gif/car_fram_images" + _value + ".gif");
      }
    }
    return Scaffold(
      backgroundColor: Constants.kdarkBlueColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: getProportionateScreenHeight(400),
            child: Stack(
              children: [
                //* /// main image
                Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    "assets/images/login_main_image_2.png",
                    width: getProportionateScreenWidth(400),
                  ),
                ),

                ///
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: getProportionateScreenHeight(20),
                    ),
                    height: getProportionateScreenHeight(220),
                    child: ImageSequenceAnimator(
                      "assets/gif/car_fram_images",
                      "frame_",
                      0,
                      5,
                      "gif",
                      54,
                      key: Key("offline"),
                      fullPaths: useFullPaths ? _fullPathsOffline : null,
                      fps: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
