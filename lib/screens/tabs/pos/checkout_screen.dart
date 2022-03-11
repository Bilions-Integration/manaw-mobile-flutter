import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/loading_widget.dart';
import 'package:my_app/controllers/cart_controller.dart';
import 'package:my_app/model/product_model.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/tabs/pos/components/product_card_checkout.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final cartController = Get.find<CartController>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
      ),
      body: Obx(
        () => (Padding(
          padding: const EdgeInsets.all(15.0),
          child: loading
              ? const LoadingWidget(
                  title: 'Refreshing',
                )
              : ListView(
                  children: cartController.products.value
                      .mapIndexed((Product product, index) {
                    product.index = index;
                    return ProductCardCheckout(
                        product: product, removed: _removed);
                  }).toList(),
                ),
        )),
      ),
    );
  }

  _removed(int? index) {
    setState(() {
      loading = true;
    });
    Future.delayed(const Duration(milliseconds: 30), () {
      final List<Product> products = List.from(cartController.products.value);
      products.removeAt(index!);
      cartController.products.value = products;
      setState(() {
        loading = false;
      });
    });
  }
}
