import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/custom_app_bar_2.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/helpers/util_models.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/model/product_detail_model.dart';
import 'package:my_app/screens/tabs/management/product/add_stock_controller.dart';
import 'package:my_app/screens/tabs/management/product/components/category_select.dart';
import 'package:my_app/screens/tabs/management/product/components/product_item.dart';
import 'package:my_app/screens/tabs/management/product/create_edit_product.dart';
import 'package:my_app/screens/tabs/management/product/product_add_stock.dart';
import 'package:my_app/screens/tabs/management/product/product_controller.dart';
import 'package:my_app/services/product_services.dart';

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
  List<ProductDetail> selectedProducts = [];
  bool refresh = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar2(
          context: context,
          title: 'manageProducts'.tr,
          isSearch: isSearch,
          toggleSearch: () {
            setState(() {
              isSearch = !isSearch;
              if (!isSearch) {
                productController.keyword.value = '';
                _reset();
              }
            });
          },
          search: (value) {
            setState(() {
              productController.keyword.value = value;
              _reset();
            });
          },
          add: () {
            _handleNavigation(action: 'create');
          }),
      body: Column(
        children: [
          CategorySelector(callback: _categoryChanged),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'productName'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightDark,
                  ),
                ),
                const Spacer(),
                Text(
                  "stock".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightDark,
                  ),
                ),
                mr(2),
                Text(
                  "sell".tr,
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
                      key: Key(refresh.toString()),
                      controller: _scrollController,
                      children: [
                        ...productController.products.value.map(
                          (product) => ProductItem(
                            product: product,
                            handler: _handleNavigation,
                            onSelect: _onItemSelection,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Styles.loading,
          Container(
            margin: const EdgeInsets.only(
              bottom: 5,
            ),
            child: selectedProducts.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: PrimaryButton(
                      onPressed: _addStock,
                      value: 'addStock'.tr,
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

  _addStock() {
    for (ProductDetail p in selectedProducts) {
      var controllerCart = addStockController.purchaseCart.value;
      int idx = controllerCart.indexOf(p);
      if (idx != -1) {
        controllerCart[idx].addStockQuantity += p.addStockQuantity;
      } else {
        controllerCart.add(p);
      }
    }
    Get.to(() => const ProductAddStock())?.then((value) {
      setState(() {
        selectedProducts = [];
        refresh = !refresh;
      });
    });
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

  _deleteProduct(int productId) async {
    bool success = await productController.deleteProduct(productId: productId);
    snackBar(
      'Success',
      'Successfully Deleted',
      icon: Icons.check_circle,
    );
    if (success) {
      _reset();
    }
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
        confirm(
          onPressed: (value) => value ? _deleteProduct(productId!) : null,
          title: "areYouSure".tr,
          message: 'deleteProductConfirm'.tr,
          cancelText: 'cancel'.tr,
          confirmText: 'delete'.tr,
        );
        break;
      case 'add_stock':
        setState(() {
          selectedProducts.add(productController.products.value
              .where((element) => element.productId == productId!)
              .first);
        });
        _addStock();
        break;
      case 'clone': 
        cloneProduct(productId);
    }
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

  _onItemSelection({required bool value, required ProductDetail product}) {
    setState(() {
      if (value) {
        selectedProducts.add(product);
      } else {
        selectedProducts.removeWhere(
            (ProductDetail element) => element.productId == product.productId);
      }
    });
  }

  _reset() {
    setState(() {
      hasFinishedLoading = false;
    });
    productController.page.value = 1;
    productController.products.value = [];
    productController.getProducts().then((value) {
      setState(() {
        hasFinishedLoading = true;
      });
    });
  }

  cloneProduct(productId) async {
    await ProductServices.clone(productId);
     _reset();
  }
}
