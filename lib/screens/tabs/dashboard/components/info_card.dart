import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

class InfoCard extends StatelessWidget {
  final double percent;
  final double balance;
  final String title;
  final Widget icon;

  const InfoCard({
    Key? key,
    required this.icon,
    required this.percent,
    required this.balance,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // width: 148,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.lightGrey,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: icon,
              ),
              mb(1),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  percent < 0
                      ? Icon(
                          Icons.arrow_downward,
                          color: AppColors.red,
                        )
                      : Icon(
                          Icons.arrow_upward,
                          color: AppColors.green,
                        ),
                  Text('$percent %'),
                ],
              ),
              mb(1),
              Text(
                '${currency()} ${cast(balance)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              mb(1),
              Text(
                title,
                style: TextStyle(color: AppColors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
