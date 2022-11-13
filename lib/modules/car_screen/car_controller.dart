import 'dart:convert';

import 'package:assessment_test_beep/modules/car_screen/product_model.dart';
import 'package:assessment_test_beep/services/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class CarController extends GetxController {
  //* for show loading indicator in UI
  RxBool isProductFetched = false.obs;

  //* (products) variable will use in UI
  RxList<ProductModel> products = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  //* Will fetch all the products and assige to (products) variable
  Future<void> fetchProducts() async {
    try {
      isProductFetched.value = true;
      var request = http.Request(
        'GET',
        Uri.parse(productUrl),
      );

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var encodedResponse = await response.stream.bytesToString();
        var decodedResponse = jsonDecode(encodedResponse);
        for (var item in decodedResponse) {
          products.add(ProductModel.fromJson(item));
        }
        Set<ProductModel> productSet = products.toSet();
        products.value = productSet.toList();
        isProductFetched.value = false;
      } else {
        print(response.reasonPhrase);
        isProductFetched.value = false;
      }
    } catch (e) {
      isProductFetched.value = false;
      print(e);
    }
  }
}
