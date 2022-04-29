import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_detail_model.dart';

class ProductController extends GetxController {
  var products = Rx<List<ProductDetail>>([]);

  var page = 1.obs;
  var limit = 20.obs;
  var keyword = ''.obs;
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
        'keyword': keyword.value,
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
      int? productId,
      required Map<String, dynamic> product}) async {
    String url = type == 'create'
        ? '/products'
        : '/products/' + productId.toString() + '?_method=PUT';
    var res = await Api.post(url,
        data: product, formData: true, showLoading: showLoading);
    if (res['success']) {
      return ProductDetail.fromJson(res['data'] as Map);
    } else {
      throw res['error'];
    }
  }

  Future<bool> deleteProduct({required int productId}) async {
    return Api.delete('/products/$productId', showLoading: true)
        .then((value) => value['success'] as bool);
  }
}
