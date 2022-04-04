import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/api.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_detail_model.dart';
import 'package:my_app/model/product_model.dart';
import 'package:my_app/screens/tabs/management/product/components/options_menu.dart';

class ProductItem extends StatefulWidget {
  final ProductDetail product;
  final int index;
  final Function handler;
  const ProductItem({
    Key? key,
    required this.product,
    required this.handler,
    required this.index,
  }) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool enableSelling = false;

  @override
  void initState() {
    setState(() {
      enableSelling = widget.product.enableSelling;
    });
    super.initState();
  }

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
                    border: 1),
                mr(1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 160,
                      child: Text(
                        widget.product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      widget.product.retailPrice.toString(),
                      style: TextStyle(color: AppColors.grey),
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
                    widget.product.instock.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
            mr(1),
            Switch(
              activeColor: AppColors.dark,
              value: enableSelling,
              onChanged: _enableSelling,
            ),
          ],
        ),
      ),
    );
  }

  _enableSelling(value) async {
    setState(() {
      enableSelling = value;
    });
    await Api.post('/products/enable/${widget.product.productId}');
  }
}
