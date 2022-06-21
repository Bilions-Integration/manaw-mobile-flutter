import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/model/product_model.dart';
import 'package:my_app/screens/tabs/pos/cart_controller.dart';
import 'package:my_app/screens/tabs/pos/category/category_selector.dart';
import 'package:my_app/screens/tabs/pos/components/product_card.dart';
import 'package:my_app/screens/tabs/pos/components/variation_select.dart';
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

  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var crossCount = (MediaQuery.of(context).size.width / 300).ceil();
    double spacing = 10;
    return Obx(
      () => Column(
        children: [
          CategorySelector(callback: _categoryChanged),
          Expanded(
            child: Container(
              color: AppColors.bg,
              padding: EdgeInsets.only(left: spacing, right: spacing),
              child: MasonryGridView.count(
                controller: _scrollController,
                crossAxisCount: crossCount,
                itemCount: posController.products.value.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = posController.products.value[index];
                  return ProductCard(
                    product: product,
                    index: index,
                    spacing: spacing,
                    crossCount: crossCount,
                    addCart: _addToCartModal,
                  );
                },
                crossAxisSpacing: spacing,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _reset();
    cartController.setAccount();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  _addCart(Product product) {
    cartController.products.value = [...cartController.products.value, product];
  }

  _addToCartModal(Product product) {
    VariationSelect(product: product, addCartCallback: _addCart).open();
  }

  _categoryChanged(CategoryModel category) {
    if (category.id == null) {
      posController.products.value = [];
      _reset();
    } else {
      posController.getProducts(category: category.id);
    }
  }

  _loadMore() {
    posController.page.value++;
    posController.getProducts();
  }

  _reset() {
    posController.endOfPage.value = false;
    posController.page.value = 1;
    posController.products.value = [];
    posController.getProducts();
  }
}
