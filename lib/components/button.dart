import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({Key? key, required this.value, required this.delete})
      : super(key: key);

  final String value;

  final Function() delete;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: delete,
        child: Text(value, style: const TextStyle(color: Colors.white)),
        color: AppColors.darkRed,
        height: 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minWidth: double.infinity);
  }
}
