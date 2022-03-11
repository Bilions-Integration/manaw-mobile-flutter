import 'package:get/get.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_model.dart';

class CartController extends GetxController {
  final products = Rx<List<Product>>([]);

  int total() {
    return products.value.length;
  }

  reset() {
    final List<Product> newProducts = List.from(products.value);
    products.value = [];
    Future.delayed(const Duration(milliseconds: 10), () {
      products.value = newProducts;
    });
  }

  String totalPrice() {
    int price = 0;
    products.value.forEach((element) {
      price += element.price * element.quantity;
    });
    return cast(price);
  }

  checkout() {
    List list = [];
    products.value.forEach((element) {
      list = [...list, element.toJson()];
    });
  }
}
