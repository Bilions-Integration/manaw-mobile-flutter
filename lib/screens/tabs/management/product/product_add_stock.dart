import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/account_model/account_model.dart';
import 'package:my_app/screens/tabs/management/invoice/manage_purchase_invoice.dart';
import 'package:my_app/screens/tabs/management/product/add_stock_controller.dart';
import 'package:my_app/screens/tabs/management/product/components/account_select.dart';
import 'package:my_app/screens/tabs/management/product/components/add_stock_product_item.dart';

class ProductAddStock extends StatefulWidget {
  const ProductAddStock({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddStockState();
  }
}

class _AddStockState extends State<ProductAddStock> {
  var addStockController = Get.put(AddStockController());

  double total = 0;
  AccountModel? selectedAccount;
  int totalProducts = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: const Text('Add Stock'),
        actions: [
          IconButton(
              onPressed: _clearCart, icon: const Icon(Icons.delete_outlined))
        ],
      ),
      body: Column(
        key: Key(totalProducts.toString()),
        children: [
          Expanded(
            child: ListView(
              children: [
                for (var product in addStockController.purchaseCart.value)
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 20, top: 12),
                    child: AddStockProductItem(
                        product: product, onChange: _onChange),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
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
                      total.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                mb(1),
                AccountSelector(callback: _onAccountChange),
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
                  disabled: selectedAccount == null,
                  onPressed: _submit,
                ),
                mb(0.5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getTotalAmount() {
    double totalAmt = 0;
    for (var product in addStockController.purchaseCart.value) {
      totalAmt += product.addStockQuantity * (product.price ?? 0);
    }
    setState(() {
      total = totalAmt;
    });
  }

  @override
  void initState() {
    totalProducts = addStockController.purchaseCart.value.length;
    super.initState();
    getTotalAmount();
  }

  _clearCart() {
    confirm(
        onPressed: (value) => value
            ? () {
                addStockController.purchaseCart.value = [];
                total = 0;
                setState(() {
                  totalProducts = addStockController.purchaseCart.value.length;
                });
              }()
            : null,
        title: "Clear all",
        message: "Do you want to clear all products?",
        confirmText: 'Clear');
  }

  _onAccountChange(data) {
    setState(() {
      selectedAccount = data;
    });
  }

  _onChange({String? action, int? productId}) {
    if (action == 'delete') {
      addStockController.purchaseCart.value
          .removeWhere((element) => element.productId == productId!);
    }
    getTotalAmount();
  }

  _submit() {
    addStockController.buyProducts(account: selectedAccount?.id).then(
          (success) => {
            if (success)
              {Get.off(() => const ManagePurchaseInvoice())}
            else
              {Get.snackbar("Failed", "An error occurred in adding stock.")}
          },
        );
  }
}
