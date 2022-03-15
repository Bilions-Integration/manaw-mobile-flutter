import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/account_model.dart';
import 'package:my_app/model/customer_model.dart';
import 'package:my_app/model/product_model.dart';
import 'package:my_app/screens/tabs/pos/components/check_actions.dart';

class CartController extends GetxController {
  final auth = Get.find<AuthController>();

  final products = Rx<List<Product>>([]);

  final account = Rx<Account?>(null);

  final customer = Rx<CustomerModel?>(null);

  final discount = Rx<dynamic>(0);

  String subTotalPrice() {
    int price = 0;
    for (Product product in products.value) {
      price += product.price * product.quantity;
    }
    return cast(price);
  }

  String tax() {
    final tax = auth.user.value?.company.tax ?? 0;
    int price = 0;
    for (Product product in products.value) {
      price += product.price * product.quantity;
    }
    return cast((price * (tax / 100)));
  }

  String totalPrice() {
    final tax = auth.user.value?.company.tax ?? 0;
    int price = 0;
    for (Product product in products.value) {
      price += product.price * product.quantity;
    }
    var discountPrice = 0;
    try {
      discountPrice = int.parse(discount.value.toString());
    } catch (e) {
      discountPrice = 0;
    }

    return cast(price - discountPrice - (price * (tax / 100)));
  }

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
        {
          "product_id": product.productId,
          "quantity": product.quantity,
          "price": product.price,
          "discount": 0,
          "discount_type": "fixed",
        }
      ];
    }
    Map params = {
      "receiver_id": customer.value?.id,
      "receiver_name": customer.value?.name,
      "receiver_email": customer.value?.email,
      "receiver_phone": customer.value?.phone,
      "shipping_address": customer.value?.address,
      "billing_address": customer.value?.address,
      "receiver_tax_id": customer.value?.taxId,
      "discount": discount,
      "discount_type": "fixed",
      "account_id": account.value?.id,
      "products": list,
    };
    console.log('PARAMS to SUBMIT => $params');
  }
}
