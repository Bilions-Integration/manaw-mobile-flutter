import 'package:flutter/material.dart';
import 'package:my_app/components/common_widget.dart';
import 'package:my_app/data/colors.dart';

class MyTextInput extends StatelessWidget {
  final String placeholder;

  final IconData icon;

  final double radius = 10.0;

  final String? column;

  final Function(String, String?) onChanged;

  _onChanged(value) {
    onChanged(value, column);
  }

  const MyTextInput(
      {Key? key,
      this.column,
      required this.placeholder,
      required this.icon,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: TextField(
        onChanged: _onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16.5),
          prefixIcon: Icon(icon),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.dark,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
          hintText: placeholder,
        ),
      ),
    );
  }
}

class PasswordInput extends StatefulWidget {
  final String placeholder;
  final IconData icon;
  final String? column;
  final Function(String, String?) onChanged;

  const PasswordInput(
      {Key? key,
      this.column,
      required this.onChanged,
      required this.placeholder,
      required this.icon})
      : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  _onChanged(value) {
    widget.onChanged(value, widget.column);
  }

  bool showPassword = true;

  _togglePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: TextField(
        onChanged: _onChanged,
        obscureText: showPassword,
        obscuringCharacter: "*",
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16.5),
          prefixIcon: Icon(widget.icon),
          suffixIcon: !showPassword
              ? IconTapper(
                  onTap: _togglePassword,
                  iconDefault: Icons.visibility,
                )
              : IconTapper(
                  onTap: _togglePassword,
                  iconDefault: Icons.visibility_off,
                ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.dark,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: widget.placeholder,
        ),
      ),
    );
  }
}
