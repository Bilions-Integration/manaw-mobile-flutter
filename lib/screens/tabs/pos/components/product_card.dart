import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  final int index;

  final int crossCount;

  final Function(Product) addCart;

  const ProductCard({
    Key? key,
    required this.product,
    required this.crossCount,
    required this.index,
    required this.addCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: (index < crossCount) ? 15.0 : 0,
        bottom: 15,
      ),
      child: borderRadiusCard(
        10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 100,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    product.images[0],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 0,
                left: 8,
                right: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.name),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${currency()} ${cast(product.price)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      MaterialButton(
                        color: AppColors.primary,
                        onPressed: () => {addCart(product)},
                        minWidth: 30,
                        elevation: 4,
                        height: 30,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          Icons.add,
                          size: 16,
                          color: AppColors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        border: 0,
      ),
    );
  }
}
