import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProduct extends StatelessWidget {
  final String type;
  final int? productId;
  const CreateProduct({Key? key, required this.type, this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type.capitalize.toString() + " Product"),
      ),
      body: Center(
        child:
            Text("Create Product Screen : Edit id : " + productId.toString()),
      ),
    );
  }
}
