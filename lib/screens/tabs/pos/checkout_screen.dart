import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/screens/tabs/pos/cart_controller.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/model/product_model.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/tabs/pos/components/check_actions.dart';
import 'package:my_app/screens/tabs/pos/components/product_card_checkout.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final cartController = Get.find<CartController>();

  bool loading = false;

  List<Product> carItems = [];

  @override
  initState() {
    super.initState();
    setState(() {
      carItems = List.from(cartController.products.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
        actions: checkoutActions(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: carItems.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: (ListView(
                      children: carItems.mapIndexed((Product product, index) {
                        product.index = index;
                        return ProductCardCheckout(product: product, removed: _removed);
                      }).toList(),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: PrimaryButton(
                        value: '',
                        child: Obx(
                          () => (Text(
                            '${currency()} ${cartController.totalPrice()} Checkout',
                            style: TextStyle(color: AppColors.white),
                          )),
                        ),
                        onPressed: _checkout),
                  )
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.noItems),
                    mb(1),
                    const Text('No items in the cart'),
                    mb(6),
                  ],
                ),
              ),
      ),
    );
  }

  _checkout() {
    confirm(
      onPressed: _confirmed,
      title: 'Checkout',
      message: "Are you sure to continue checkout?",
      confirmText: 'Yes',
    );
  }

  _confirmed(confirm) {
    if (confirm) {
      cartController.checkout();
    }
  }

  _removed(int? index) {
    List<Product> tempCartItem = List.from(carItems);
    setState(() {
      carItems = [];
    });
    final List<Product> products = List.from(cartController.products.value);
    cartController.products.value = [];
    Future.delayed(const Duration(milliseconds: 10), () {
      tempCartItem.removeAt(index!);
      setState(() {
        carItems = tempCartItem;
      });
      products.removeAt(index);
      cartController.products.value = products;
    });
  }
}
