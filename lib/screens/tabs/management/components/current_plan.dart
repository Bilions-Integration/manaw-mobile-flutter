import 'package:flutter/material.dart';
import 'package:my_app/data/assets.dart';

class CurrentPlan extends StatelessWidget {
  const CurrentPlan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 55,
          height: 55,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(AppAssets.bronzeIcon),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color(0xe8e8e8ff),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Bronze Plan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                'Expired in 22 Mar, 2022',
                style: TextStyle(
                  color: Colors.black45,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
