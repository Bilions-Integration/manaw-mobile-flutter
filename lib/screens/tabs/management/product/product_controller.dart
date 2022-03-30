import 'dart:async';

import 'package:get/get.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_model.dart';

class ProductController extends GetxController {
  var products = Rx<List<Product>>([]);

  var page = 1.obs;
  var limit = 20.obs;

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
      final resProducts = (res['data']['data'] as List)
          .map((e) => Product.fromJson(e as Map))
          .toList();
      products.value = [...products.value, ...resProducts];
    } catch (e) {
      console.warn(e.toString());
    }
  }

  Future<Product> getProduct({bool showLoading = false, int? productId}) async {
    try {
      var res = await Api.get('/products/$productId');
      final resProduct = Product.fromJson(res['data']);
      return resProduct;
    } catch (e) {
      console.warn(e.toString());
      rethrow;
    }
  }

  Future<Product> saveProduct(
      {bool showLoading = false,
      String type = 'create',
      required Product product}) async {
    String url = type == 'create'
        ? '/products'
        : '/products/' + product.productId.toString() + '?_method=PUT';
    try {
      var res = await Api.post(url,
          data: product.toJson(), formData: true, showLoading: showLoading);
      console.log('type of productId', payload: res['data']['id'].runtimeType);
      console.log('type of index', payload: res['data']['index'].runtimeType);
      console.log('type of instock',
          payload: res['data']['instock'].runtimeType);
      console.log('type of retail_price',
          payload: res['data']['retail_price'].runtimeType);
      console.log('type of buy_price',
          payload: res['data']['buy_price'].runtimeType);
      console.log('type of category_id',
          payload: res['data']['category_id'].runtimeType);
      console.log('type of quantity',
          payload: res['data']['quantity'].runtimeType);
      return Product.fromJson(res['data']);
      // console.log("Post complete : " + res.toString());
    } catch (e) {
      console.warn(e.toString());
      return product;
    }
  }
}
