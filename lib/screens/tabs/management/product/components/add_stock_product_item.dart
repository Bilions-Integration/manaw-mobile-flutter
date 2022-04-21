import 'package:flutter/material.dart';
import 'package:my_app/model/product_detail_model.dart';

class AddStockProductItem extends StatefulWidget {
  final ProductDetail product;
  const AddStockProductItem({Key? key, required this.product})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductItemState();
  }
}

class _ProductItemState extends State<AddStockProductItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(widget.product.name);
  }
}
