import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/screens/tabs/management/product/components/category_select.dart';

class ManageProduct extends StatefulWidget {
  const ManageProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
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
          children: [CategorySelector(callback: _categoryChanged)],
        ));
  }

  _categoryChanged(CategoryModel category) {
    // posController.getProducts(category: category.id);
    console.log('Category Changed');
  }
}
