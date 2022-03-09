import 'package:flutter/material.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(AppAssets.imgCard),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product['name'],
                  // overflow: TextOverflow.ellipsis,
                ),
                // AppWidget.marginBottom(1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '1,000 K',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    MaterialButton(
                      color: AppColors.dark,
                      onPressed: () => {},
                      minWidth: 20,
                      height: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: Icon(
                        Icons.add,
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
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
