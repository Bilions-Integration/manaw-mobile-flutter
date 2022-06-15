import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/image.dart';
import 'package:my_app/model/product_detail_model.dart';

class AddStockProductItem extends StatefulWidget {
  final ProductDetail product;
  final Function({String? action, int? productId}) onChange;
  const AddStockProductItem(
      {Key? key, required this.product, required this.onChange})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductItemState();
  }
}

class _ProductItemState extends State<AddStockProductItem> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            mr(1),
            borderRadiusCard(
                10,
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: MyImage.network(
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
                  width: 100,
                  child: Text(
                    widget.product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  (widget.product.buyPrice ?? widget.product.retailPrice)
                      .toString(),
                  style: TextStyle(color: AppColors.grey),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: _decrease,
              icon: SvgPicture.asset(AppAssets.icMinus),
            ),
            SizedBox(child: Text(count.toString())),
            IconButton(
              onPressed: _increase,
              icon: SvgPicture.asset(AppAssets.icPlus),
            ),
          ],
        )
      ],
    );
  }

  @override
  void initState() {
    count = widget.product.addStockQuantity;
    super.initState();
  }

  _decrease() {
    setState(() {
      if (count > 1) {
        count--;
        widget.product.addStockQuantity--;
      } else {
        _remove();
      }
    });
    widget.onChange();
  }

  _increase() {
    setState(() {
      count++;
      widget.product.addStockQuantity++;
    });
    widget.onChange();
  }

  _remove() {
    confirm(
        onPressed: (value) => value
            ? () {
                widget.onChange(
                    action: 'delete', productId: widget.product.productId);
              }()
            : null,
        title: "Remove ?",
        message: "Do you want to remove this product?",
        confirmText: 'Remove');
  }
}
