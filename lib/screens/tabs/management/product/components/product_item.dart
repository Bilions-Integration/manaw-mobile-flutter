import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_detail_model.dart';
import 'package:my_app/screens/tabs/management/product/add_stock_controller.dart';
import 'package:my_app/screens/tabs/management/product/components/options_menu.dart';

class ProductItem extends StatefulWidget {
  final ProductDetail product;
  final int index;
  final Function({required String action, int? productId}) handler;
  final Function({required bool value, required ProductDetail product})
      onSelect;
  const ProductItem({
    Key? key,
    required this.product,
    required this.handler,
    required this.index,
    required this.onSelect,
  }) : super(key: key);
  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  final addStockController = Get.put(AddStockController());

  bool enableSelling = false;
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        OptionsMenu(
                productId: widget.product.productId, handler: widget.handler)
            .open();
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 10, top: (widget.index == 1) ? 0 : 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              value: selected,
              onChanged: _onCheckBoxChange,
            ),
            Row(
              children: [
                borderRadiusCard(
                  10,
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      widget.product.images[0],
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  border: 1,
                ),
                mr(1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 160,
                      child: Text(
                        widget.product.name,
                        style: TextStyle(
                          color: AppColors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      widget.product.retailPrice.toString(),
                      style: TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            widget.product.instock <= 0
                ? Text(
                    'Out',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColors.red),
                  )
                : Text(
                    widget.product.negativeStock == 1
                        ? '-'
                        : widget.product.instock.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
            mr(1),
            Switch(
              activeColor: AppColors.primary,
              value: enableSelling,
              onChanged: _enableSelling,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    setState(() {
      enableSelling = widget.product.enableSelling;
    });
    super.initState();
  }

  _enableSelling(value) async {
    setState(() {
      enableSelling = value;
    });
    await Api.post('/products/enable/${widget.product.productId}',
        showLoading: false);
  }

  _onCheckBoxChange(bool? value) {
    setState(() {
      selected = value as bool;
    });

    widget.onSelect(value: value!, product: widget.product);
  }
}
