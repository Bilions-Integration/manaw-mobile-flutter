import 'package:get/get.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_model.dart';

class ProductController extends GetxController {
  var products = Rx<List<Product>>([]);
  var product = Rxn<Product>();

  var page = 1.obs;
  var limit = 20.obs;

  getProducts({bool showLoading = false, dynamic category}) async {
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

  getProduct({bool showLoading = false, int? productId}) async {
    try {
      var res = await Api.get('/products/$productId');
      final resProduct = Product.fromJson(res['data']);
      console.log(resProduct);
      product.value = resProduct;
    } catch (e) {
      console.warn(e.toString());
    }
  }
}
