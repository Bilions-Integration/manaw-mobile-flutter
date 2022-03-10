import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

class LoadingWidget extends StatelessWidget {
  final String? title;

  const LoadingWidget({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.white,
            strokeWidth: 1.0,
          ),
          mb(1),
          Text(
            title ?? 'Loading...',
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.normal,
              fontSize: 17,
              decoration: TextDecoration.none,
            ),
          )
        ],
      ),
    );
  }
}
