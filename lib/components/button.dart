import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.value,
    this.disabled = false,
    this.width = double.infinity,
    this.height = 50,
    required this.onPressed,
  }) : super(key: key);

  final String value;

  final bool disabled;

  final double width;

  final double height;

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => {disabled ? null : onPressed()},
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      color: disabled ? AppColors.lightDark : AppColors.dark,
      height: height,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      minWidth: width,
    );
  }
}