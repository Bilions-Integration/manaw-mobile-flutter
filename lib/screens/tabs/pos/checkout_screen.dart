import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/controllers/cart_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
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
        centerTitle: false,
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              AppAssets.icAccount,
              color: AppColors.white,
            ),
            onPressed: () => {_showCouponModal},
          ),
          IconButton(
            icon: SvgPicture.asset(
              AppAssets.icCoupon,
              color: AppColors.white,
            ),
            onPressed: () => {_showCouponModal},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: SvgPicture.asset(
                AppAssets.icPerson,
                color: AppColors.white,
              ),
              onPressed: () => {_showCustomerModal},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: (ListView(
                  children: cartController.products.value
                      .mapIndexed((Product product, index) {
                    product.index = index;
                    return ProductCardCheckout(
                        product: product, removed: _removed);
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
          ),
        ),
      ),
    );
  }

  _showCouponModal() {}

  _showCustomerModal() {}

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
    final List<Product> products = List.from(cartController.products.value);
    cartController.products.value = [];
    Future.delayed(const Duration(milliseconds: 10), () {
      products.removeAt(index!);
      cartController.products.value = products;
    });
  }
}
