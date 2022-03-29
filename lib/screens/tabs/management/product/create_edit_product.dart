import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/category_picker.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/components/select_box.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/model/product_model.dart';
import 'package:my_app/screens/tabs/management/product/components/product_image_picker.dart';
import 'package:my_app/screens/tabs/management/product/components/product_packages.dart';
import 'package:my_app/screens/tabs/management/product/product_controller.dart';
import 'package:my_app/services/category_service.dart';

class CreateProduct extends StatefulWidget {
  final String type;
  final int? productId;

  CreateProduct({Key? key, required this.type, this.productId})
      : super(key: key);

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  List<CategoryModel> categoryList = [];
  CategoryModel? selectedCategory;

  final productController = Get.put(ProductController());

  Map params = {
    "name": "",
    "category_id": null,
    "retail_price": null,
    "enable_selling": 1,
    "barcode": null,
    "buy_price": null,
    "images": [],
    "unit": null,
    'units': []
  };

  @override
  void initState() {
    super.initState();
    _getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        title: Text(widget.type.capitalize.toString() + " Product"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ProductImagePicker(onChanged: _onNewImages),
                      mb(2),
                      hr(),
                      mb(2),
                      MyTextInput(
                        value: params['name'],
                        column: 'name',
                        placeholder: 'Enter Product Name',
                        onChanged: _setParams,
                        label: 'Product Name *',
                      ),
                      MyTextInput(
                        column: 'retail_price',
                        value: params['retail_price'],
                        placeholder: '0',
                        onChanged: _setParams,
                        label: 'Sale Price *',
                      ),
                      SelectBox(
                        placeholder: 'Select Category',
                        label: 'Category',
                        value: selectedCategory?.name,
                        onClick: _showCategoryPicker,
                      ),
                      MyTextInput(
                        value: params['barcode'],
                        column: 'barcode',
                        placeholder: 'ABC-1234567890',
                        onChanged: _setParams,
                        label: 'Barcode',
                      ),
                      MyTextInput(
                        column: 'buy_price',
                        value: params['buy_price'],
                        placeholder: '0',
                        onChanged: _setParams,
                        label: 'Purchase Price',
                      ),
                      MyTextInput(
                        column: 'unit',
                        value: params['unit'],
                        placeholder: 'pcs',
                        onChanged: _setParams,
                        label: 'Product Unit',
                      ),
                      if (widget.type == 'edit')
                        ProductPackages(
                          onChanged: _setPackages,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Material(
            elevation: 20,
            child: Container(
              color: AppColors.lightGrey,
              padding: const EdgeInsets.all(20),
              child: PrimaryButton(value: 'CRATE PRODUCT', onPressed: () {}),
            ),
          )
        ],
      ),
    );
  }

  _setPackages(List<Map> packages) {
    params['units'] = packages;
  }

  _onNewImages(List<dio.MultipartFile> newImages) {
    setState(() {
      params['images'] = newImages;
    });
  }

  _getCategory() async {
    if (categoryList.isEmpty) {
      List<CategoryModel> initialCategories = [];
      List<CategoryModel> categories = await CategoryService.get();
      setState(() {
        categoryList = [...initialCategories, ...categories];
      });
    }
  }

  _showCategoryPicker() async {
    await _getCategory();
    CategoryPicker(
      onSelect: (CategoryModel val) {
        setState(() {
          params['category_id'] = val.id;
          selectedCategory = val;
        });
      },
      menuList: categoryList,
    ).open();
  }

  _setParams(val, String? column) {
    setState(() {
      params[column] = val;
    });
  }

  _getProduct() async {
    console.log('Get product run : ' + widget.productId.toString());
    if (widget.productId != null) {
      Product product =
          await productController.getProduct(productId: widget.productId);
      // Product? product = productController.product.value;
      console.log('_getProduct : ');
      console.log(product.name);
      // setState(() {
      //   params = {
      //     "name": product?.name,
      //     "category_id": product?.categoryId,
      //     "retail_price": product?.retailPrice,
      //     "enable_selling": 1,
      //     "barcode": product?.barcode,
      //     "buy_price": product?.purchasePrice,
      //     "images": product?.images,
      //     "unit": product?.unit,
      //     'units': product?.units
      //   };
      // });

      setState(() {
        params = {
          "name": product.name,
          "category_id": product.categoryId,
          "retail_price": product.retailPrice,
          "enable_selling": 1,
          "barcode": product.barcode,
          "buy_price": product.purchasePrice,
          "images": product.images,
          "unit": product.unit,
          'units': product.units
        };
      });
    }
  }
}
