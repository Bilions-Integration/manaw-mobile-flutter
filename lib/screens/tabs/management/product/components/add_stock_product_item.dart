import 'package:flutter/material.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_detail_model.dart';

class AddStockProductItem extends StatefulWidget {
  final ProductDetail product;
  final Function onChange;
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
  void initState() {
    count = widget.product.addStockQuantity;
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
            IconButton(onPressed: _decrease, icon: Icon(Icons.remove_circle)),
            // SizedBox(width: 20, child: Text(count.toString())),
            SizedBox(
                width: 60,
                child: MyTextInput(
                  placeholder: '',
                  onFieldSubmitted: _onChanged,
                  value: count,
                  key: Key(count.toString()),
                  onChanged: (String e, String? col) {},
                  numberOnly: true,
                )),
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
        widget.product.quantity--;
      }
    });
    widget.onChange();
  }

  _increase() {
    setState(() {
      count++;
      widget.product.quantity++;
    });
    widget.onChange();
  }

  _onChanged(String text, String? e) {
    int? num = int.tryParse(text);
    setState(() {
      if (num != null) {
        count = num;
        widget.product.quantity = num;
      }
    });
    widget.onChange();
  }
}
