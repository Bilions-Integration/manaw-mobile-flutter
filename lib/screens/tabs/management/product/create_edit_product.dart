import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/category_picker.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/components/loading_widget.dart';
import 'package:my_app/components/select_box.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/util_models.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/model/product_detail_model.dart';
import 'package:my_app/screens/tabs/management/product/components/product_image_picker.dart';
import 'package:my_app/screens/tabs/management/product/components/product_packages.dart';
import 'package:my_app/screens/tabs/management/product/product_controller.dart';
import 'package:my_app/services/category_service.dart';

class CreateProduct extends StatefulWidget {
  final String type;
  final int? productId;

  const CreateProduct({Key? key, required this.type, this.productId})
      : super(key: key);

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  List<CategoryModel> categoryList = [];
  CategoryModel? selectedCategory;

  final productController = Get.put(ProductController());
  Map? errors;
  Map<String, dynamic> params = {
    "name": "",
    "category_id": null,
    "retail_price": null,
    "enable_selling": 1,
    "barcode": null,
    "buy_price": null,
    "images[]": [],
    "type": null,
    "old_images[]": [],
    "unit": null,
    'instock': null,
    'units': []
  };
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Text(widget.type.capitalize.toString() + " Product"),
      ),
      body: isLoading
          ? const Center(
              child: LoadingWidget(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            ProductImagePicker(
                                onChanged: _onNewImages,
                                oldImages: params['old_images[]']),
                            mb(2),
                            hr(),
                            mb(2),
                            MyTextInput(
                              value: params['name'],
                              column: 'name',
                              placeholder: 'Enter Product Name',
                              onChanged: _setParams,
                              error: errors,
                              label: 'Product Name',
                              isRequired: true,
                            ),
                            MyTextInput(
                              column: 'retail_price',
                              value: params['retail_price'],
                              placeholder: '0',
                              onChanged: _setParams,
                              error: errors,
                              numberOnly: true,
                              label: 'Sale Price',
                              isRequired: true,
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
                              error: errors,
                              label: 'Barcode',
                            ),
                            MyTextInput(
                              column: 'buy_price',
                              value: params['buy_price'],
                              placeholder: '0',
                              onChanged: _setParams,
                              error: errors,
                              label: 'Purchase Price',
                              numberOnly: true,
                            ),
                            MyTextInput(
                              column: 'unit',
                              value: params['unit'],
                              placeholder: 'pcs',
                              onChanged: _setParams,
                              error: errors,
                              label: 'Product Unit',
                            ),
                            if (widget.type == 'edit')
                              ProductPackages(
                                productId: widget.productId,
                                afterMutation: _getProduct,
                                options: params['units'],
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
                    child: PrimaryButton(
                        value: widget.type.toUpperCase() + ' PRODUCT',
                        disabled:
                            !isFormValid(['name', 'retail_price'], params),
                        onPressed: () {
                          _saveProduct();
                        }),
                  ),
                )
              ],
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.type == 'edit') {
      isLoading = true;
      _getProduct();
    }
  }

  _getCategory() async {
    if (categoryList.isEmpty) {
      List<CategoryModel> initialCategories = [];
      var res = await CategoryService.get({'page': 1, 'limit': 10});
      List<CategoryModel> categories = res['categories'];
      setState(() {
        categoryList = [...initialCategories, ...categories];
      });
    }
  }

  _getProduct() async {
    if (widget.productId != null) {
      productController.getProduct(productId: widget.productId).then((product) {
        setState(() {
          selectedCategory = product.category;
          params = product.toJson();
          params['units'] = product.units;
          isLoading = false;
        });
        return product;
      }).catchError((e) {
        console.log(e.toString());
        return ProductDetail.emptyProduct();
      });
    }
  }

  _onNewImages(List<dio.MultipartFile> newImages) {
    List oldImages = (params['old_images[]'] as List);
    setState(() {
      oldImages.isNotEmpty
          ? oldImages.removeWhere(
              (element) => element.toString().contains('placeholder.png'))
          : null;
      params['images[]'] = newImages;
    });
  }

  _saveProduct() {
    productController
        .saveProduct(
            product: params,
            type: widget.type,
            productId: widget.productId,
            showLoading: true)
        .then((ProductDetail product) {
      var result =
          ProductMutationResult(type: widget.type, id: product.productId);
      Get.back(result: result);
    }).catchError((e) {
      setState(() {
        errors = e as Map?;
      });
    });
  }

  _setParams(val, String? column) {
    setState(() {
      params[column!] = val;
      errors?[column] = null;
    });
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
}
