import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/components/image_preview.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/common_model.dart';
import 'package:my_app/screens/tabs/management/product/components/product_image_picker.dart';

class CreateProduct extends StatefulWidget {
  final String type;
  final int? productId;
  const CreateProduct({Key? key, required this.type, this.productId}) : super(key: key);

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  Map params = {
    "name": "Hello",
    "category_id": null,
    "retail_price": null,
    "enable_selling": 1,
    "barcode": null,
    "buy_price": null,
    "images": [],
    "unit": null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        title: Text(widget.type.toString() + " Product"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ProductImagePicker(onNewImages: _onNewImages),
                mb(2),
                hr(),
                mb(2),
                MyTextInput(
                  value: params['name'],
                  placeholder: 'Enter Product Name',
                  onChanged: _setParams,
                  label: 'Product Name *',
                ),
                MyTextInput(
                  value: params['barcode'],
                  placeholder: 'ABC-1234567890',
                  onChanged: _setParams,
                  label: 'Barcode',
                ),
                MyTextInput(
                  value: params['retail_price'],
                  placeholder: '0',
                  onChanged: _setParams,
                  label: 'Sale Price *',
                ),
                MyTextInput(
                  value: params['buy_price'],
                  placeholder: '0',
                  onChanged: _setParams,
                  label: 'Purchase Price *',
                ),
                MyTextInput(
                  value: params['unit'],
                  placeholder: 'pcs',
                  onChanged: _setParams,
                  label: 'Product Unit *',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onNewImages(List<MultipartFile> newImages) {
    setState(() {
      params['images'] = newImages;
    });
  }

  _setParams(val, String? column) {
    setState(() {
      params[column] = val;
    });
  }
}
