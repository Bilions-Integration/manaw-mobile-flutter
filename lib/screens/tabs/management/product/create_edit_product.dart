import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_app/data/colors.dart';

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
      body: Column(
        children: [
          Center(
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.add_rounded),
                ),
                Text('Add Product Image'),
              ],
            ),
          ),
          Wrap(
            children: [
              Text('Product Name'),
              TextField(
                  decoration: InputDecoration(
                hintText: 'Enter Product Name',
              )),
            ],
          ),
          Wrap(
            children: [
              Text('Barcode'),
              TextField(
                  decoration: InputDecoration(
                hintText: 'Enter Barcode Name',
              )),
            ],
          ),
          Wrap(
            children: [
              Text('Price'),
              TextField(
                  decoration: InputDecoration(
                hintText: 'Enter Product Name',
              )),
            ],
          ),
          Wrap(
            children: [
              Text('Stock'),
              TextField(
                  decoration: InputDecoration(
                hintText: 'Enter Product Name',
              )),
            ],
          )
        ],
      ),
    );
  }
}
