import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/model/product_model.dart';
import 'package:my_app/screens/tabs/management/product/create_edit_product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final int index;
  const ProductItem({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(CreateProduct(type: 'edit', productId: product.productId)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  index.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 7,
                  height: 5,
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(5)),
                    child: Image.network(product.images[0]),
                  ),
                ),
                const SizedBox(
                  width: 7,
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(product.retailPrice.toString()),
                  ],
                ),
              ],
            ),
            product.instock <= 0
                ? Text(
                    'Out of stock',
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.red, fontSize: 13),
                  )
                : Text(
                    product.instock.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
          ],
        ),
      ),
    );
  }
}
