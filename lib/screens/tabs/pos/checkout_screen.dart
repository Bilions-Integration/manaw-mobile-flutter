import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/util_models.dart';
import 'package:my_app/model/product_model.dart';
import 'package:my_app/screens/tabs/pos/cart_controller.dart';
import 'package:my_app/screens/tabs/pos/components/check_actions.dart';
import 'package:my_app/screens/tabs/pos/components/confirm_print.dart';
import 'package:my_app/screens/tabs/pos/components/product_card_checkout.dart';
import 'package:my_app/services/pos_service.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final cartController = Get.find<CartController>();
  final auth = Get.find<AuthController>();

  bool loading = false;

  List<Product> carItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            var result = ProductMutationResult(type: 'reset');
            Get.back(result: result);
          },
        ),
        actions: checkoutActions(onClear: () {
          setState(() {
            carItems = [];
          });
        }),
      ),
      body: carItems.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: (ListView(
                    children: carItems.mapIndexed((Product product, index) {
                      product.index = index;
                      return Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: ProductCardCheckout(
                            product: product, removed: _removed),
                      );
                    }).toList(),
                  )),
                ),
                Obx(
                  () => (Container(
                    color: AppColors.white,
                    padding: const EdgeInsets.only(
                      bottom: 20.0,
                      top: 13,
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: cartController.customer.value != null &&
                                  cartController.customer.value!.id != null
                              ? Row(
                                  children: [
                                    Text('customer'.tr),
                                    const Spacer(),
                                    Text(cartController.customer.value!.name)
                                  ],
                                )
                              : null,
                        ),
                        Row(
                          children: [
                            Text('subTotal'.tr),
                            const Spacer(),
                            Text(cartController.subTotalPrice().toString())
                          ],
                        ),
                        mb(1),
                        Row(
                          children: [
                            Text(
                              'tax'.trParams({
                                'percent':
                                    auth.user.value?.company.tax.toString() ??
                                        ''
                              }),
                            ),
                            const Spacer(),
                            Text(cartController.tax().toString())
                          ],
                        ),
                        mb(1),
                        Row(
                          children: [
                            Text('discount'.tr),
                            const Spacer(),
                            Text(cartController.discount.value.toString())
                          ],
                        ),
                        mb(1),
                        Row(
                          children: [
                            Container(
                              constraints: const BoxConstraints(minWidth: 100),
                              child: Text(
                                '${currency()} ${cartController.totalPrice()}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            mr(2),
                            Expanded(
                              child: PrimaryButton(
                                width: 250,
                                value: '',
                                child: Text(
                                  'checkout'.tr,
                                  style: TextStyle(color: AppColors.white),
                                ),
                                onPressed: _checkout,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
                ),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppAssets.noItems),
                  mb(1),
                  Text('emptyCart'.tr),
                  mb(6),
                ],
              ),
            ),
    );
  }

  @override
  initState() {
    super.initState();
    setState(() {
      carItems = List.from(cartController.products.value);
    });
  }

  printConfirm(id) {
    String text = Platform.isAndroid ? 'continuePrint'.tr : 'saveReceipt'.tr;
    confirmPrintDialog(
      onPressed: (confirm) {
        _confirmedPrint(confirm, id);
      },
      title: 'printReceipt'.tr,
      message: text,
      confirmText: 'print'.tr,
      onDownload: () async {
        PosService service = PosService();
        await service.downloadReceipt(id);
      },
    );
  }

  _checkout() {
    confirm(
      onPressed: _confirmed,
      title: 'checkout'.tr,
      message: "confirmCheckout".tr,
      confirmText: 'checkout'.tr,
    );
  }

  _confirmed(confirm) {
    if (confirm) {
      cartController.checkout((id) {
        if (id != 0) {
          setState(() {
            carItems = [];
          });
          printConfirm(id);
        }
      });
    }
  }

  _confirmedPrint(confirm, id) {
    if (!confirm) {
      return;
    }
    PosService service = PosService();
    service.print(id);
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
