import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

class DashboardTopProducts extends StatefulWidget {
  const DashboardTopProducts({Key? key}) : super(key: key);

  @override
  State<DashboardTopProducts> createState() => _DashboardTopProductsState();
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
              children: [
                Text(
                  'Top Products',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                mb(2),
                const ProductCard(
                  number: 1,
                  title: 'iPhone 12 pro',
                  count: 10000,
                  percent: 10,
                ),
                const ProductCard(
                  number: 2,
                  title: 'iPhone 12 pro',
                  count: 10000,
                  percent: 10,
                ),
                const ProductCard(
                  number: 3,
                  title: 'iPhone 12 pro',
                  count: 10000,
                  percent: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Widget? image;
  final String title;
  final int number;
  final double count;
  final double percent;

  const ProductCard({
    Key? key,
    this.image,
    required this.title,
    required this.number,
    required this.count,
    required this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                number.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              mr(2),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  'https://www.zdnet.com/a/img/resize/b2677166f21490f76917908d251bdc3365525d65/2021/04/19/16cfc8be-eaf5-4e37-b1f9-ec3e13d1081c/image-2.jpg?width=1200&height=900&fit=crop&auto=webp',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              mr(1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    count.round().toString(),
                    style: TextStyle(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Text('${cast(percent.round())} %'),
              const Text(''),
            ],
          )
        ],
      ),
    );
  }
}
