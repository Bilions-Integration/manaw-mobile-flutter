import 'dart:developer';
import 'package:get/get.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_model.dart';

class POSController extends GetxController {
  var products = Rx<List<Product>>([]);

  var page = 1.obs;
  var limit = 20.obs;

  getProducts({bool showLoading = false, dynamic category}) async {
    try {
      if (category != null) {
        products.value = [];
        page.value = 1;
      }
      var res = await Api.get('/pos/products', showLoading: showLoading, data: {
        "page": page.value,
        "limit": limit.value,
        "category": category,
      });
      final resProducts = res['data']['data'];
      console.log("Before mapping");
      final mapProducts =
          (resProducts as List).map((e) => Product.fromJson(e as Map)).toList();
      products.value = [...products.value, ...mapProducts];
      console.log("after mapping");
    } catch (e) {
      inspect(e);
    }
  }
}
