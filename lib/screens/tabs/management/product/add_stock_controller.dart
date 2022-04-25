import 'package:get/get.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/model/product_detail_model.dart';

class AddStockController extends GetxController {
  var purchaseCart = Rx<List<ProductDetail>>([]);

  Future<bool> buyProducts({required account}) async {
    try {
      var products = purchaseCart.value.map((e) => {
            "product_id": e.productId,
            "quantity": e.quantity,
            "price": e.price
          });
      await Api.post('/invoices/purchase',
          data: {'account_id': account, 'products': products.toList()});
      return true;
    } catch (e) {
      return false;
    }
  }
}
