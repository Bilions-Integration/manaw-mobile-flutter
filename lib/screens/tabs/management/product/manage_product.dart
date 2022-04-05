import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/loading_widget.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/util_models.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/screens/tabs/management/product/components/category_select.dart';
import 'package:my_app/screens/tabs/management/product/components/product_item.dart';
import 'package:my_app/screens/tabs/management/product/create_edit_product.dart';
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
  bool hasFinishedLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    console.log("manage product init state");
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.dark,
          title: const Text("Product"),
          actions: <Widget>[
            InkWell(
              onTap: () {
                console.log('Action 1 pressed');
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12, left: 12),
                child: SvgPicture.asset(AppAssets.icSearch,
                    color: AppColors.white),
              ),
            ),
            IconButton(
              onPressed: () {
                // ProductCreateSheet().open();
                _handleNavigation("create", null);
              },
              icon: const Icon(Icons.add_rounded),
            ),
          ],
        ),
        body: Column(
          children: [
            CategorySelector(callback: _categoryChanged),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 15),
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
                      padding: const EdgeInsets.only(left: 20.0, right: 5),
                      child: ListView(
                        controller: _scrollController,
                        children: [
                          for (var item in productController.products.value
                              .asMap()
                              .entries)
                            ProductItem(
                              product: item.value,
                              index: item.key + 1,
                              handler: _handleNavigation,
                            ),
                        ],
                      ),
                    ),
                  )
                : const LoadingWidget(),
          ],
        ));
  }

  _handleNavigation(String action, int? productId) {
    console.log('Handle On tap : ' + action);
    switch (action) {
      case 'create':
      case 'edit':
        Get.to(() => CreateProduct(
              type: action,
              productId: productId,
            ))?.then(_afterMutation);
        break;
    }
  }

  _afterMutation(result) {
    if (result?.type == 'create') {
      console.log("result create : ", payload: result.id);
      Get.to(CreateProduct(type: 'edit', productId: result.id))
          ?.then(_afterMutation);
    }
    if (result?.type != null) {
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
    productController.getProducts(category: category.id ?? '');
  }
}
