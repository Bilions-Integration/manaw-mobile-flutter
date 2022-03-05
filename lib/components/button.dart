import 'package:flutter/material.dart';
import 'package:my_app/components/colors.dart';

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
    );
  }
}
