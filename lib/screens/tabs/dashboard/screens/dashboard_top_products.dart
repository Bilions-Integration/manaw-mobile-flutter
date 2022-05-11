import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/top_products_model.dart';

class DashboardTopProducts extends StatefulWidget {
  final List<TopProductsModel> topProducts;
  const DashboardTopProducts({Key? key, required this.topProducts})
      : super(key: key);

  @override
  State<DashboardTopProducts> createState() => _DashboardTopProductsState();
}

class ProductCard extends StatelessWidget {
  final TopProductsModel product;
  final int number;

  const ProductCard({
    Key? key,
    required this.product,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    product.image,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                mr(1),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        product.totalQuantity.round().toString(),
                        style: TextStyle(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          mr(1),
          Column(
            children: [
              Text(
                '${cast(product.percent)} %',
                style: TextStyle(
                  color: AppColors.primary,
                ),
              ),
              const Text(''),
            ],
          )
        ],
      ),
    );
  }
}

class _DashboardTopProductsState extends State<DashboardTopProducts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        borderRadiusCard(
          10,
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.topProducts.isEmpty
                  ? [
                      Text(
                        'Top Products',
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      mb(10),
                      Center(
                        child: SvgPicture.asset(AppAssets.noProducts),
                      ),
                      mb(1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            'No product sold yet',
                          )
                        ],
                      ),
                      mb(8),
                    ]
                  : [
                      Text(
                        'Top Products',
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      mb(2),
                      ...widget.topProducts
                          .mapIndexed(
                            (TopProductsModel product, index) => ProductCard(
                              number: index + 1,
                              product: product,
                            ),
                          )
                          .toList(),
                    ],
            ),
          ),
        ),
      ],
    );
  }
}
