import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/helpers/firebase.dart';
import 'package:my_app/screens/tabs/pos/category/category_selector.dart';
import 'package:my_app/screens/tabs/pos/components/product_card.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({Key? key}) : super(key: key);

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  @override
  void initState() {
    _updateFirebaseToken();
    super.initState();
  }

  _updateFirebaseToken() async {
    await updateFirebaseToken();
  }

  final auth = Get.find<AuthController>();

  List products = [
    {'name': "this is long product name and very long"},
    {'name': "short"},
    {'name': "short"},
    {'name': "short"},
    {'name': "this is long product name and very long very very very long"},
    {'name': "this is long product name and very long"},
    {'name': "short"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategorySelector(context: context),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              final product = products[index];
              return ProductCard(product: product);
            },
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
        )),
      ],
    );
  }
}
