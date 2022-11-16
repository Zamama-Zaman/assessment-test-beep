// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:assessment_test_beep/modules/car_screen/car_controller.dart';
import 'package:assessment_test_beep/modules/recharge_screen/recharge_screen.dart';
import 'package:assessment_test_beep/widgets/loading_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'product_model.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({Key? key}) : super(key: key);

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  final _carController = Get.find<CarController>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Constants.kdarkBlueColor,
      body: Obx(
        () => _carController.isProductFetched.value
            ? loadingIndicatorWidget()
            : SafeArea(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: SizeConfig.screenWidth * 0.18),
                          Text(
                            'My Cars',
                            style: TextStyle(
                              color: Constants.kWhiteColor,
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          /// Add button
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RechargeScreen(),
                                  ),
                                );
                                // _carController.fetchProducts();
                              },
                              child: SvgPicture.asset(
                                  "assets/svg/add_icon_car.svg")),
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
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: SizeConfig.screenHeight * 0.03),
                              ...List.generate(
                                _carController.products.toSet().toList().length,
                                (index) => Column(
                                  children: [
                                    CarCard(
                                      productModel:
                                          _carController.products[index],
                                    ),
                                    SizedBox(
                                        height: SizeConfig.screenHeight * 0.02),
                                  ],
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.15),
                            ],
                          ),
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

class CarCard extends StatelessWidget {
  final ProductModel productModel;
  const CarCard({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(150),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: SizeConfig.screenWidth * 0.05),
          Container(
            width: getProportionateScreenWidth(390),
            height: getProportionateScreenHeight(150),
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(15),
              vertical: getProportionateScreenHeight(15),
            ),
            decoration: BoxDecoration(
              color: Constants.kWhiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                //* /// Main Image
                Container(
                  width: getProportionateScreenWidth(95),
                  height: getProportionateScreenHeight(120),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(productModel.image),
                    ),
                  ),
                ),

                SizedBox(width: SizeConfig.screenWidth * 0.04),

                //* /// Description and other stuff
                Expanded(
                  child: Column(
                    textDirection: TextDirection.ltr,
                    children: [
                      Container(
                        width: double.infinity,
                        height: getProportionateScreenHeight(60),
                        color: Colors.transparent,
                        child: Column(
                          textDirection: TextDirection.ltr,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              textDirection: TextDirection.ltr,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        productModel.image,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.screenWidth * 0.02,
                                ),
                                Text(
                                  // 'BMW',
                                  productModel.category,
                                  style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: getProportionateScreenWidth(
                                      16,
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: getProportionateScreenWidth(5)),
                              child: Text(
                                '7 Series',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: Constants.kDarkGreyColor,
                                  fontSize: getProportionateScreenWidth(
                                    13,
                                  ),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //* /// Color Palet no and Year
                      Container(
                        width: double.infinity,
                        height: getProportionateScreenHeight(60),
                        color: Colors.transparent,
                        child: Row(
                          textDirection: TextDirection.ltr,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Color
                            Column(
                              textDirection: TextDirection.ltr,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.005,
                                ),
                                Text(
                                  'Color',
                                  style: TextStyle(
                                    color: Constants.kgreenColor,
                                    fontSize: getProportionateScreenWidth(14),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.005,
                                ),
                                Row(
                                  textDirection: TextDirection.ltr,
                                  children: [
                                    SvgPicture.asset(
                                        "assets/svg/small_car_icon.svg"),
                                    SizedBox(
                                      width: SizeConfig.screenWidth * 0.02,
                                    ),
                                    Text(
                                      'Black',
                                      style: TextStyle(
                                        color: Constants.kDarkGreyColor,
                                        fontSize: getProportionateScreenWidth(
                                          12,
                                        ),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            //* /// Plate No.
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.02,
                            ),
                            Column(
                              textDirection: TextDirection.ltr,
                              children: [
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.005,
                                ),
                                Text(
                                  'Plate No',
                                  style: TextStyle(
                                    color: Constants.kgreenColor,
                                    fontSize: getProportionateScreenWidth(14),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.005,
                                ),
                                Text(
                                  // 'ELX 5987',
                                  productModel.price.toString(),
                                  style: TextStyle(
                                    color: Constants.kDarkGreyColor,
                                    fontSize: getProportionateScreenWidth(
                                      12,
                                    ),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),

                            //* /// Year
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.02,
                            ),
                            Column(
                              textDirection: TextDirection.ltr,
                              children: [
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.005,
                                ),
                                Text(
                                  'Year',
                                  style: TextStyle(
                                    color: Constants.kgreenColor,
                                    fontSize: getProportionateScreenWidth(
                                      14,
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.005,
                                ),
                                Text(
                                  '2022',
                                  style: TextStyle(
                                    color: Constants.kDarkGreyColor,
                                    fontSize: getProportionateScreenWidth(
                                      12,
                                    ),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
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

          SizedBox(width: SizeConfig.screenWidth * 0.04),

          //* /// Delete Container
          Container(
            width: getProportionateScreenWidth(65),
            height: getProportionateScreenHeight(131),
            decoration: BoxDecoration(
              color: Constants.kLightRedColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Image.asset(
                  "assets/images/delete_icon.png",
                  width: getProportionateScreenWidth(24),
                  height: getProportionateScreenHeight(24),
                ),
                Text(
                  'Delete',
                  style: TextStyle(
                    color: Constants.kDarkRedColor,
                    fontSize: getProportionateScreenWidth(12),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: SizeConfig.screenWidth * 0.02),

          //* /// Edit Container
          Container(
            width: getProportionateScreenWidth(65),
            height: getProportionateScreenHeight(131),
            decoration: BoxDecoration(
              color: Constants.kLightGreenColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Image.asset(
                  "assets/images/edit_icon.png",
                  width: getProportionateScreenWidth(24),
                  height: getProportionateScreenHeight(24),
                ),
                Text(
                  'Edit',
                  style: TextStyle(
                    color: Constants.kgreenColor,
                    fontSize: getProportionateScreenWidth(12),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          ///
          SizedBox(width: SizeConfig.screenWidth * 0.05),
        ],
      ),
    );
  }
}
