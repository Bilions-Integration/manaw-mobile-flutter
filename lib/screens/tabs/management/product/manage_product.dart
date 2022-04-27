import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/custom_app_bar_2.dart';
import 'package:my_app/components/loading_widget.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/util_models.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/screens/tabs/management/product/add_stock_controller.dart';
import 'package:my_app/screens/tabs/management/product/components/category_select.dart';
import 'package:my_app/screens/tabs/management/product/components/product_item.dart';
import 'package:my_app/screens/tabs/management/product/create_edit_product.dart';
import 'package:my_app/screens/tabs/management/product/product_add_stock.dart';
import 'package:my_app/screens/tabs/management/product/product_controller.dart';

class ManageProduct extends StatefulWidget {
  const ManageProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final productController = Get.put(ProductController());
  final addStockController = Get.put(AddStockController());
  bool hasFinishedLoading = false;
  final ScrollController _scrollController = ScrollController();
  bool isSearch = false;
  int selectedProductCount = 0;

  @override
  void initState() {
    super.initState();
    _reset();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar2(
          context: context,
          title: 'Manage Products',
          isSearch: isSearch,
          toggleSearch: () {},
          search: () {},
          add: () {
            _handleNavigation(action: 'create');
          }),
      body: Column(
        children: [
          CategorySelector(callback: _categoryChanged),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Product Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightDark,
                  ),
                ),
                const Spacer(),
                Text(
                  "Stock",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightDark,
                  ),
                ),
                mr(2),
                Text(
                  "Sell",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightDark,
                  ),
                )
              ],
            ),
          ),
          hasFinishedLoading
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5),
                    child: ListView(
                      controller: _scrollController,
                      children: [
                        for (var item
                            in productController.products.value.asMap().entries)
                          ProductItem(
                            product: item.value,
                            index: item.key + 1,
                            handler: _handleNavigation,
                            onSelect: _onItemSelection,
                          ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: LoadingWidget(
                    title: 'Loading',
                  ),
                ),
          Container(
            key: Key(selectedProductCount.toString()),
            child: addStockController.purchaseCart.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PrimaryButton(
                      onPressed: () => {Get.to(() => const ProductAddStock())},
                      value: 'Add Stock',
                    ),
                  )
                : const SizedBox(
                    width: 10,
                    height: 0,
                  ),
          )
        ],
      ),
    );
  }

  _onItemSelection() {
    setState(() {
      selectedProductCount = addStockController.purchaseCart.value.length;
    });
  }

  _handleNavigation({required String action, int? productId}) {
    switch (action) {
      case 'create':
      case 'edit':
        Get.to(() => CreateProduct(
              type: action,
              productId: productId,
            ))?.then((res) => _afterMutation(res as ProductMutationResult));
        break;
      case 'delete':
        List<DialogAction> actions = [
          DialogAction(name: 'Cancel', type: 'cancel'),
          DialogAction(
              name: 'Delete',
              type: 'danger',
              handler: () {
                _deleteProduct(productId!);
              })
        ];
        AppWidget.showAlertBox(
            context: context,
            actions: actions,
            message: 'Are you sure to delete this product?');
        break;
      case 'add_stock':
        addStockController.purchaseCart.value.add(productController
            .products.value
            .where((element) => element.productId == productId!)
            .first);
        Get.to(() => const ProductAddStock());
        break;
    }
  }

  _deleteProduct(int productId) async {
    bool success = await productController.deleteProduct(productId: productId);
    // var snackBar =
    //     SnackBar(content: Text('Delete ' + (success ? 'success' : 'failed')));
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Get.snackbar('Success', "Delete Success", icon: Icon(Icons.delete));
    if (success) {
      _reset();
    }
  }

  _afterMutation(ProductMutationResult? result) {
    if (result?.type == 'create') {
      Get.to(() => CreateProduct(type: 'edit', productId: result?.id))
          ?.then((res) => _afterMutation(res as ProductMutationResult));
      return null;
    }
    if (result != null) {
      _reset();
    }
  }

  _reset() {
    productController.page.value = 1;
    productController.products.value = [];
    productController.getProducts().then((value) {
      setState(() {
        hasFinishedLoading = true;
      });
    });
  }

  _loadMore() {
    if (productController.total.value >
        productController.products.value.length) {
      productController.page.value++;
      productController.getProducts().then((value) {
        setState(() {
          hasFinishedLoading = true;
        });
      });
    }
  }

  _categoryChanged(CategoryModel category) {
    setState(() {
      hasFinishedLoading = false;
    });
    productController.getProducts(category: category.id ?? '').then((value) {
      setState(() {
        hasFinishedLoading = true;
      });
    });
  }
}
