import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_detail_model.dart';

class AddStockProductItem extends StatefulWidget {
  final ProductDetail product;
  const AddStockProductItem({Key? key, required this.product})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductItemState();
  }
}

class _ProductItemState extends State<AddStockProductItem> {
  int count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            IconButton(onPressed: _decrease, icon: Icon(Icons.remove_circle)),
            SizedBox(width: 20, child: Text(count.toString())),
            IconButton(onPressed: _increase, icon: Icon(Icons.add_circle)),
          ],
        )
      ],
    );
  }

  _decrease() {
    setState(() {
      if (count > 1) {
        count--;
      }
    });
  }

  _increase() {
    setState(() {
      count++;
    });
  }
}
