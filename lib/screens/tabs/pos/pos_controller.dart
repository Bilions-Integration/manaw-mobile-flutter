import 'package:get/get.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_model.dart';

class POSController extends GetxController {
  var products = Rx<List<Product>>([]);

  var page = 1.obs;
  var limit = 8.obs;

  getProducts({bool showLoading = false}) async {
    try {
      var res = await Api.get('/pos/products', showLoading: showLoading, data: {
        "page": page.value,
        "limit": limit.value,
      });
      final resProducts = res['data']['data'];
      final mapProducts =
          (resProducts as List).map((e) => Product.fromJson(e as Map)).toList();

      products.value = [...products.value, ...mapProducts];
    } catch (e) {
      console.log(e.toString());
    }
  }
}