import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';

class TextInput extends StatelessWidget {
  final String placeholder;

  final IconData icon;

  const TextInput({Key? key, required this.placeholder, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
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
