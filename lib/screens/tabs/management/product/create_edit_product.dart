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

  Map params = {
    "name": "",
    "category_id": null,
    "retail_price": null,
    "enable_selling": 1,
    "barcode": null,
    "buy_price": null,
    "images": [],
    "type": null,
    "old_images": [],
    "unit": null,
    'instock': null,
    'units': []
  };
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.type == 'edit') {
      isLoading = true;
      _getProduct();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark,
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
                                oldImages: params['old_images']),
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
                    child: PrimaryButton(
                        value: widget.type.toUpperCase() + ' PRODUCT',
                        onPressed: () {
                          _saveProduct();
                        }),
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
    List oldImages = (params['old_images'] as List);
    setState(() {
      oldImages.isNotEmpty
          ? oldImages.removeWhere(
              (element) => element.toString().contains('placeholder.png'))
          : null;
      params['images'] = newImages;
    });
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
      if (column == 'retail_price' || column == 'buy_price') {
        params[column] = int.parse(val);
      } else {
        params[column] = val;
      }
    });
  }

  _saveProduct() {
    late ProductDetail product;
    if (widget.type == 'create') {
      product = ProductDetail(
          productId: 0,
          name: params['name'],
          images: params['images'] ?? [],
          instock: 0,
          retailPrice: params['retail_price'],
          buyPrice: params['buy_price'],
          barcode: params['barcode'],
          type: params['type'] ?? '',
          unit: params['unit'],
          units: params['units'],
          enableSelling: params['enable_selling'] == 1 ? true : false,
          categoryId: params['category_id']);
    } else {
      product = ProductDetail(
          productId: widget.productId!,
          name: params['name'],
          images: params['images'] ?? [],
          oldImages: params['old_images'],
          instock: params['instock'],
          retailPrice: params['retail_price'],
          buyPrice: params['buy_price'],
          barcode: params['barcode'],
          type: params['type'] ?? '',
          units: params['units'],
          unit: params['unit'],
          enableSelling: params['enable_selling'] == 1 ? true : false,
          categoryId: params['category_id']);
      console.log('product update : ' + product.toString());
    }
    productController
        .saveProduct(product: product, type: widget.type, showLoading: true)
        .then((product) {
      var result =
          ProductMutationResult(type: widget.type, id: product.productId);
      Get.back(result: result);
    }).catchError((e) {});
  }

  _getProduct() async {
    if (widget.productId != null) {
      productController.getProduct(productId: widget.productId).then((product) {
        setState(() {
          selectedCategory = product.category;
          params = {
            "name": product.name,
            "category_id": product.categoryId,
            "retail_price": product.retailPrice,
            "enable_selling": 1,
            "barcode": product.barcode,
            "buy_price": product.buyPrice,
            "type": product.type,
            "old_images": product.images,
            'instock': product.instock,
            "unit": product.unit,
            'units': product.units
          };
          console.log('setState old iamges : ' +
              params["old_images"].length.toString());
          isLoading = false;
        });
        return product;
      }).catchError((e) {
        console.log(e.toString());
        return ProductDetail.emptyProduct();
      });
    }
  }
}
