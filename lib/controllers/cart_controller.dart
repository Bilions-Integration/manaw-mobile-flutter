import 'package:get/get.dart';
import 'package:my_app/model/product_model.dart';

class CartController extends GetxController {
  final products = Rx<List<Product>>([]);

  int total() {
    return products.value.length;
  }
}
