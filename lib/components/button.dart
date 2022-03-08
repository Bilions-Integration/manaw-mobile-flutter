import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({Key? key, required this.value, required this.onPressed})
      : super(key: key);

  final String value;

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        child: Text(value,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        color: AppColors.dark,
        height: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minWidth: double.infinity);
  }
}
