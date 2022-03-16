import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/screens/tabs/management/product/components/category_select.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _reset();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        console.log('Reached bottom');
        _loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.dark,
          title: const Text("Product"),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  console.log('Action 1 pressed');
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  console.log('Action 2 pressed');
                },
                icon: const Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  console.log('Action 3 pressed');
                },
                icon: const Icon(Icons.more_horiz)),
          ],
        ),
        body: Column(
          children: [
            CategorySelector(callback: _categoryChanged),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightDark,
                    ),
                  ),
                  Text(
                    "Instock",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightDark,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  height: 500,
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      for (var item in productController.products.value)
                        Text('Product : ' + item.name)
                    ],
                  )),
            ),
          ],
        ));
  }

  _reset() {
    productController.page.value = 1;
    productController.products.value = [];
    productController.getProducts();
    console.log('Reset products : ');
  }

  _loadMore() {
    productController.page.value++;
    productController.getProducts();
  }

  _categoryChanged(CategoryModel category) {
    // posController.getProducts(category: category.id);
    console.log('Category Changed');
  }
}
