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
    for (Product product in products.value) {
      price += product.price * product.quantity;
    }
    return cast(price);
  }

  checkout() {
    List list = [];
    for (Product product in products.value) {
      list = [
        ...list,
        {
          "product_id": product.productId,
          "quantity": product.quantity,
          "price": product.price,
          "discount": 0,
          "discount_type": "fixed"
        }
      ];
    }
    Map params = {
      "receiver_id": 1,
      "receiver_name": "guest",
      "receiver_email": "",
      "receiver_phone": "",
      "shipping_address": "",
      "billing_address": "",
      "discount": 0,
      "discount_type": "fixed",
      // "account_id": 1,
      "products": list,
    };
    console.log(params);
  }
}
