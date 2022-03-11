import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: cartController.products.value
              .mapIndexed((Product product, index) {
            return ProductCardCheckout(
              product: product,
              index: index,
            );
          }).toList(),
        ),
      ),
    );
  }
}
