import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/account_model.dart';
import 'package:my_app/model/product_model.dart';
import 'package:my_app/screens/tabs/pos/components/check_actions.dart';

class CartController extends GetxController {
  final products = Rx<List<Product>>([]);

  final account = Rx<Account?>(null);

  setAccount() {
    final box = GetStorage();
    var cachedAccount = box.read('@account');
    if (cachedAccount != null) {
      try {
        var decodedString = jsonDecode(cachedAccount);
        account.value = Account.fromJson(decodedString);
      } catch (e) {
        console.log(e.toString());
      }
    }
  }

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
    console.log('checked out called');
    if (account.value == null) {
      showAccountModal(
          callback: () => {
                _submit(),
              });
    } else {
      _submit();
    }
  }

  _submit() {
    List list = [];
    for (Product product in products.value) {
      list = [
        ...list,
        {"product_id": product.productId, "quantity": product.quantity, "price": product.price, "discount": 0, "discount_type": "fixed"}
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
      "account_id": account.value?.id,
      "products": list,
    };
    console.log('PARAMS to SUBMIT => $params');
  }
}
