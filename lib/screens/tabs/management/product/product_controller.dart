import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_model.dart';

class ProductController extends GetxController {
  var products = Rx<List<Product>>([]);

  var page = 1.obs;
  var limit = 20.obs;

  getProducts({bool showLoading = false, dynamic category}) async {
    try {
      var res = await Api.get('/products', showLoading: showLoading, data: {
        'page': page.value,
        'limit': limit.value,
      });
      console.log('just after got ');
      final resProducts = (res['data']['data'] as List)
          .map((e) => Product.fromJson(e as Map))
          .toList();
      console.log(' after convert ');
      products.value = [...products.value, ...resProducts];
      console.log('Got products : ');
      console.log(products.value);
    } catch (e) {
      console.warn(e.toString());
    }
  }
}
