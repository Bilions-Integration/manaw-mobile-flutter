import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/model/product_model.dart';

class POSController extends GetxController {
  var products = Rx<List<Product>>([]);

  var endOfPage = Rx<bool>(false);

  var page = 1.obs;
  var limit = 20.obs;

  getProducts({bool showLoading = false, dynamic category}) async {
    try {
      if (endOfPage.value) {
        return;
      }

      if (category != null) {
        products.value = [];
        page.value = 1;
      }

      Map<String, dynamic> data = {
        "page": page.value,
        "limit": limit.value,
      };

      if (category != null) {
        data['category'] = category;
      }

      var res =
          await Api.get('/pos/products', showLoading: showLoading, data: data);
      final resProducts = res['data']['data'];
      final mapProducts =
          (resProducts as List).map((e) => Product.fromJson(e as Map)).toList();

      if (mapProducts.isEmpty) {
        endOfPage.value = true;
      }

      products.value = [...products.value, ...mapProducts];
    } catch (e) {
      inspect(e);
    }
  }
}
