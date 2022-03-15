import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/screens/tabs/pos/cart_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_model.dart';

class ProductCardCheckout extends StatefulWidget {
  final Product product;
  final Function(int?) removed;

  const ProductCardCheckout({
    Key? key,
    required this.removed,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductCardCheckout> createState() => _ProductCardCheckoutState();
}

class _ProductCardCheckoutState extends State<ProductCardCheckout> {
  final cartController = Get.find<CartController>();

  int quantity = 0;

  @override
  void initState() {
    quantity = widget.product.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double top = (widget.product.index! == 0) ? 15.0 : 0.0;
    return Padding(
      padding: EdgeInsets.only(
        bottom: 6,
        top: top,
      ),
      child: borderRadiusCard(
        10,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  widget.product.images[0],
                  width: 70,
                ),
              ),
              mr(2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.name),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${currency()} ${widget.product.price}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        _changeQuantity('minus');
                      },
                      icon: SvgPicture.asset(AppAssets.icMinus),
                    ),
                  ),
                  Text('$quantity'),
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        _changeQuantity('add');
                      },
                      icon: SvgPicture.asset(AppAssets.icPlus),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
        border: 0,
      ),
    );
  }

  _changeQuantity(String type) {
    if (type == 'add') {
      final newQuantity = quantity + 1;
      setState(() {
        quantity = newQuantity;
      });
      cartController.products.value[widget.product.index!].quantity = quantity;
    } else {
      final newQuantity = quantity - 1;
      if (newQuantity == 0) {
        confirm(
          onPressed: _confirmRemove,
          title: 'Confirm',
          message: 'Are you sure you want to remove ${widget.product.name}?',
        );
      } else {
        setState(() {
          quantity = newQuantity;
        });
        cartController.products.value[widget.product.index!].quantity = quantity;
      }
    }
    cartController.reset();
  }

  _confirmRemove(bool confirm) {
    if (confirm) {
      cartController.products.value[widget.product.index!].quantity = 0;
      widget.removed(widget.product.index!);
    }
  }
}
