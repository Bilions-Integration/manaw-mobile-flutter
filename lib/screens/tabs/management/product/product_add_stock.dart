import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/account_model/account_model.dart';
import 'package:my_app/model/company_model.dart';
import 'package:my_app/screens/tabs/management/product/components/account_select.dart';
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
  double total = 0;
  AccountModel? selectedAccount;

  @override
  void initState() {
    super.initState();
    getTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        title: const Text('Add Stock'),
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
                    child: AddStockProductItem(
                        product: product, onChange: _onChange),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
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
                //Account Select here
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
                  onPressed: _submit,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onChange() {
    getTotalAmount();
  }

  _onAccountChange(data) {
    console.log('on select account', payload: data);
    setState(() {
      selectedAccount = data;
    });
  }

  getTotalAmount() {
    double totalAmt = 0;
    for (var product in productController.purchaseCart.value) {
      console.log('price : ', payload: product.price);
      totalAmt += product.quantity * (product.price ?? 0);
    }
    setState(() {
      total = totalAmt;
    });
  }

  _submit() {}
}
