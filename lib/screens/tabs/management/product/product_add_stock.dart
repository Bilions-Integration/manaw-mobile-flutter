import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/tabs/management/product/components/add_stock_product_item.dart';
import 'package:my_app/screens/tabs/management/product/components/product_item.dart';
import 'package:my_app/screens/tabs/management/product/product_controller.dart';

class ProductAddStock extends StatefulWidget {
  const ProductAddStock({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddStockState();
  }
}

class _AddStockState extends State<ProductAddStock> {
  var productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        title: Text('Add Stock'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                for (var product in productController.purchaseCart.value)
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 20, top: 12),
                    child: AddStockProductItem(product: product),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                mb(1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total amount",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      getTotalAmount().toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                mb(1),
                Row(
                  children: [
                    Icon(
                      Icons.shopping_cart_checkout_outlined,
                      color: AppColors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'This checkout is for purchasing products',
                      style: TextStyle(color: AppColors.grey),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                PrimaryButton(
                    value: 'Checkout',
                    onPressed: () {
                      console.log('text');
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _handler({required String action, int? productId}) {}
  _onSelect() {}

  getTotalAmount() {
    double total = 0;
    for (var product in productController.purchaseCart.value) {
      total += product.quantity;
    }
    return total;
  }
}
