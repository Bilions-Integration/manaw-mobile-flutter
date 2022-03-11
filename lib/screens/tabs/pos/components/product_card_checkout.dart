import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/cart_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_model.dart';

class ProductCardCheckout extends StatefulWidget {
  final Product product;
  final int index;

  const ProductCardCheckout({
    Key? key,
    required this.index,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
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
                        '${currency()} ${widget.product.price} x $quantity',
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
                  IconButton(
                    onPressed: () {
                      _changeQuantity('minus');
                    },
                    icon: SvgPicture.asset(AppAssets.icMinus),
                  ),
                  Text('$quantity'),
                  IconButton(
                    onPressed: () {
                      _changeQuantity('add');
                    },
                    icon: SvgPicture.asset(AppAssets.icPlus),
                  ),
                ],
              ))
            ],
          ),
        ),
        border: 2,
      ),
    );
  }

  _changeQuantity(String type) {
    console.log(type);
    if (type == 'add') {
      setState(() {
        quantity = quantity + 1;
      });
      console.log(
          'Product ID => ${cartController.products.value[widget.index].toJson()}');
      cartController.products.value[widget.index].quantity = quantity;
    } else {
      setState(() {
        quantity = quantity - 1;
      });
      console.log(cartController.products.value[widget.index]);
      cartController.products.value[widget.index].quantity = quantity;
    }
  }
}
