import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';

class ProductAddStock extends StatefulWidget {
  const ProductAddStock({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddStockState();
  }
}

class _AddStockState extends State<ProductAddStock> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        title: Text('Add Stock'),
      ),
      body: Center(
        child: Text('Hello'),
      ),
    );
  }
}
