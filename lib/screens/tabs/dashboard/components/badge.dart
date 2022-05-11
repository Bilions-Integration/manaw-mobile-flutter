import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';

class Badge extends StatelessWidget {
  final String title;
  final bool active;
  final Function() onPressed;

  const Badge({
    Key? key,
    required this.title,
    required this.active,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: ActionChip(
        onPressed: onPressed,
        backgroundColor: active ? AppColors.primary : AppColors.white,
        label: Text(
          title,
          style: TextStyle(
            color: active ? AppColors.white : AppColors.black,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
