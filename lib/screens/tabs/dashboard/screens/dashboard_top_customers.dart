import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/image.dart';
import 'package:my_app/model/top_customers_model.dart';

class CustomerCard extends StatelessWidget {
  final TopCustomersModel customer;
  final int number;

  const CustomerCard({
    Key? key,
    required this.customer,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: MyImage.network(
                  customer.image,
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
                    customer.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    customer.amount.toString(),
                    style: TextStyle(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashboardTopCustomers extends StatefulWidget {
  final List<TopCustomersModel> topCustomers;
  const DashboardTopCustomers({Key? key, required this.topCustomers})
      : super(key: key);

  @override
  State<DashboardTopCustomers> createState() => _DashboardTopCustomersState();
}

class _DashboardTopCustomersState extends State<DashboardTopCustomers> {
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
              children: widget.topCustomers.isEmpty
                  ? [
                      Text(
                        'topCustomers'.tr,
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      mb(10),
                      Center(
                        child: SvgPicture.asset(AppAssets.noCustomers),
                      ),
                      mb(1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'noCustomerYet'.tr,
                          )
                        ],
                      ),
                      mb(8),
                    ]
                  : [
                      Text(
                        'topCustomers'.tr,
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      mb(2),
                      ...widget.topCustomers
                          .mapIndexed(
                            (TopCustomersModel customer, i) =>
                                CustomerCard(number: i + 1, customer: customer),
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
