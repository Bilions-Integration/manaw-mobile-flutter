import 'package:flutter/material.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  final int index;

  const ProductCard({
    Key? key,
    required this.product,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: (index == 0 || index == 1) ? 8.0 : 0),
      child: borderRadiusCard(
        10,
        Column(
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
      ),
    );
  }
}
