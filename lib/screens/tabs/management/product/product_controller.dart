import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_detail_model.dart';
import 'package:my_app/model/product_model.dart';

class ProductController extends GetxController {
  var products = Rx<List<ProductDetail>>([]);

  var page = 1.obs;
  var limit = 20.obs;
  var total = 0.obs;

  Future<void> getProducts({bool showLoading = false, dynamic category}) async {
    try {
      if (category != null) {
        products.value = [];
        page.value = 1;
      }
      var res = await Api.get('/products', showLoading: showLoading, data: {
        'page': page.value,
        'limit': limit.value,
        'category': category,
      });
      total.value = res['data']['total'];
      final resProducts = (res['data']['data'] as List).map((e) {
        return ProductDetail.fromJson(e as Map);
      }).toList();
      products.value = [...products.value, ...resProducts];
    } catch (e) {
      inspect(e);
    }
  }

  Future<ProductDetail> getProduct(
      {bool showLoading = false, int? productId}) async {
    try {
      var res = await Api.get('/products/$productId');
      final resProduct = ProductDetail.fromJson(res['data']);
      return resProduct;
    } catch (e) {
      inspect(e);
      console.warn(e.toString());
      rethrow;
    }
  }

  Future<ProductDetail> saveProduct(
      {bool showLoading = false,
      String type = 'create',
      required ProductDetail product}) async {
    String url = type == 'create'
        ? '/products'
        : '/products/' + product.productId.toString() + '?_method=PUT';
    try {
      var res = await Api.post(url,
          data: product.toJson(), formData: true, showLoading: showLoading);
      return ProductDetail.fromJson(res['data']);
    } catch (e) {
      console.warn(e.toString());
      inspect(e);
      return product;
    }
  }
}
