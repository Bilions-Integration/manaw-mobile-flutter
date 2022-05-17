import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/model/product_model.dart';
import 'package:my_app/model/product_option_model.dart';

class VariationSelect {
  final Product product;
  final Function addCartCallback;
  const VariationSelect({required this.product, required this.addCartCallback});

  void open() {
    BuildContext context = currentContext();
    showModalBottomSheet(
        context: context,
        shape: Styles.topOnlyBorderRadius(15),
        builder: (builder) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.7,
            child:
                VariationSelector(product: product, callBack: addCartCallback),
          );
        });
  }
}

class VariationSelector extends StatelessWidget {
  final Product product;
  final Function callBack;
  const VariationSelector(
      {Key? key, required this.callBack, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Variation",
          style: Styles.h2,
        ),
        mb(0.2),
        Text(
          product.name,
          style: Styles.l3,
        ),
        Expanded(
          child: ListView(
            children: [
              ...product.units.map(
                (e) => Column(
                  children: [
                    mb(1),
                    InkWell(
                      splashColor: AppColors.lightPurple,
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        _select(e);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.name,
                              style: Styles.h3,
                            ),
                            Text(
                              '${currency()} ${e.salePrice}',
                              style: Styles.t2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _select(ProductOption option) {
    final newProduct = Product.fromJson(product.toJson());
    newProduct.price =
        option.salePrice > 0 ? option.salePrice : newProduct.price;
    newProduct.unit = option;
    callBack(newProduct);
  }
}
