import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            for (var product in productController.purchaseCart.value)
              AddStockProductItem(product: product)
          ],
        ));
  }

  _handler({required String action, int? productId}) {}
  _onSelect() {}
}
