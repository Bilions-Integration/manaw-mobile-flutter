import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/image.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/model/product_model.dart';
import 'package:my_app/model/unit_model.dart';
import 'package:my_app/model/view_image.dart';

class VariationSelect {
  final Product product;
  final Function addCartCallback;
  const VariationSelect({required this.product, required this.addCartCallback});

  void open() {
    BuildContext context = currentContext();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: Styles.topOnlyBorderRadius(15),
        builder: (builder) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.9,
            child:
                VariationSelector(product: product, callBack: addCartCallback),
          );
        });
  }
}

class VariationSelector extends StatefulWidget {
  final Product product;
  final Function callBack;
  const VariationSelector(
      {Key? key, required this.callBack, required this.product})
      : super(key: key);

  @override
  State<VariationSelector> createState() => _VariationSelectorState();
}

class _VariationSelectorState extends State<VariationSelector> {
  Unit? selectedUnit;
  String note = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "addToCart".tr,
          style: Styles.h2,
        ),
        mb(0.5),
        InkWell(
          onTap: () {
            viewImages(product: widget.product, selectedUnit: selectedUnit);
          },
          child: SizedBox(
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: MyImage.network(
                selectedUnit?.image ?? widget.product.images[0],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        mb(0.5),
        Text(
          widget.product.name,
          style: Styles.h2,
        ),
        Expanded(
          child: ListView(
            children: [
              mb(1),
              if (widget.product.units.isNotEmpty) Text('productVariation'.tr),
              ...widget.product.units.map(
                (Unit e) => Column(
                  children: [
                    mb(1),
                    InkWell(
                      splashColor: AppColors.lightPurple,
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        _select(e);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2,
                              color: e == selectedUnit
                                  ? AppColors.primary
                                  : AppColors.borderColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: MyImage.network(
                                  e.image ?? widget.product.images[0],
                                  fit: BoxFit.cover,
                                  width: 35,
                                  height: 35),
                            ),
                            mr(1),
                            Expanded(
                              child: Text(
                                e.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Styles.t3,
                              ),
                            ),
                            mr(1),
                            Text(
                              '${e.addPrice ? '+' : ''} ${currency()} ${e.salePrice}',
                              style: Styles.t2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              mb(2),
              Text('cartNote'.tr),
              mb(1),
              MyTextInput(
                  placeholder: 'noteToCart'.tr,
                  textarea: true,
                  onChanged: (String s, String? col) {
                    setState(() {
                      note = s;
                    });
                  }),
              mb(2),
            ],
          ),
        ),
        PrimaryButton(
          value: "addToCart".tr,
          onPressed: _addToCart,
          disabled: !_isButtonActive(),
        )
      ],
    );
  }

  _addToCart() {
    final newProduct = Product.fromJson(widget.product.toJson());
    if (selectedUnit != null) {
      if (selectedUnit!.addPrice) {
        newProduct.price = newProduct.price + selectedUnit!.salePrice;
      } else {
        newProduct.price = selectedUnit!.salePrice > 0
            ? selectedUnit!.salePrice
            : newProduct.price;
      }
      newProduct.unit = selectedUnit;
    }
    newProduct.note = note;
    widget.callBack(newProduct);
    Navigator.pop(context);
  }

  _isButtonActive() {
    if (widget.product.units.isEmpty) {
      return true;
    } else if (selectedUnit == null) {
      return false;
    }
    return true;
  }

  _select(Unit unit) {
    setState(() {
      selectedUnit = unit;
    });
  }
}
