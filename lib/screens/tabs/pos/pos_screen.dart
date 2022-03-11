import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/screens/tabs/pos/cart_controller.dart';
import 'package:my_app/helpers/firebase.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_model.dart';
import 'package:my_app/screens/tabs/pos/category/category_selector.dart';
import 'package:my_app/screens/tabs/pos/components/product_card.dart';
import 'package:my_app/screens/tabs/pos/pos_controller.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({Key? key}) : super(key: key);

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  final posController = Get.put(POSController());
  final cartController = Get.find<CartController>();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    updateFirebaseToken();
    super.initState();
    _reset();
    cartController.setAccount();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        console.log('ended');
        _loadMore();
      }
    });
  }

  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          CategorySelector(context: context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: MasonryGridView.count(
                controller: _scrollController,
                crossAxisCount: 2,
                itemCount: posController.products.value.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = posController.products.value[index];
                  return ProductCard(
                    product: product,
                    index: index,
                    addCart: _addCart,
                  );
                },
                crossAxisSpacing: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _addCart(Product product) {
    final newProduct = Product.fromJson(product.toJson());
    cartController.products.value = [...cartController.products.value, newProduct];
  }

  _reset() {
    posController.page.value = 1;
    posController.products.value = [];
    posController.getProducts();
  }

  _loadMore() {
    posController.page.value++;
    posController.getProducts();
    console.log(posController.products.value.length.toString());
  }
}
