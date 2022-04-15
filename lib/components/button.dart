import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.value,
    this.child,
    this.disabled = false,
    this.width = double.infinity,
    this.height = 50,
    required this.onPressed,
  }) : super(key: key);

  final String value;

  final Widget? child;

  final bool disabled;

  final double width;

  final double height;

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => {disabled ? null : onPressed()},
      child: child ??
          Text(
            value.toUpperCase(),
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
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

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    required this.value,
    this.child,
    this.disabled = false,
    this.width = double.infinity,
    this.height = 50,
    required this.onPressed,
  }) : super(key: key);

  final String value;

  final Widget? child;

  final bool disabled;

  final double width;

  final double height;

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        elevation: 0,
        color: AppColors.lightGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () => {disabled ? null : onPressed()},
        child: child ??
            Text(
              value.toUpperCase(),
              style: TextStyle(
                fontSize: 13,
                color: AppColors.black,
              ),
            ),
      ),
    );
  }
}
