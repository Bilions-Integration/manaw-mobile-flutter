import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';

class MyTextInput extends StatelessWidget {
  final String placeholder;

  final IconData icon;

  final double radius = 10.0;

  const MyTextInput({Key? key, required this.placeholder, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16.5),
          prefixIcon: Icon(icon),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderColor, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.dark, width: 1.0),
            borderRadius: BorderRadius.circular(radius),
          ),
          hintText: placeholder),
    );
  }
}

class PasswordInput extends StatelessWidget {
  final String placeholder;

  final IconData icon;

  const PasswordInput({Key? key, required this.placeholder, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      obscuringCharacter: "*",
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16.5),
          prefixIcon: Icon(icon),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderColor, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.dark, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: placeholder),
    );
  }
}
