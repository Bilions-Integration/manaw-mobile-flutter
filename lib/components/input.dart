import 'package:flutter/material.dart';
import 'package:my_app/components/common_widget.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

class MyTextInput extends StatelessWidget {
  final String placeholder;

  final String? label;

  final IconData? icon;

  final double radius = 10.0;

  final String? column;

  final bool? numberOnly;

  final bool textarea;

  final dynamic value;

  final bool readOnly;

  final bool isRequired;

  final Function(String, String?) onChanged;
  final Function(String, String?)? onFieldSubmitted;

  final Map? error;

  const MyTextInput({
    Key? key,
    this.column,
    this.label,
    this.textarea = false,
    this.value,
    required this.placeholder,
    this.icon,
    required this.onChanged,
    this.onFieldSubmitted,
    this.numberOnly = false,
    this.readOnly = false,
    this.error,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Row(
              children: [
                SizedBox(
                  height: 18,
                  child: Row(
                    children: [
                      Text(
                        label!.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey,
                        ),
                      ),
                      mr(0.3),
                      if (isRequired)
                        Text(
                          '*',
                          style: TextStyle(fontSize: 20, color: AppColors.red),
                        )
                    ],
                  ),
                ),
                mr(2),
                error?[column] != null
                    ? SizedBox(
                        height: 18,
                        child: Text(
                          error?[column],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.normal,
                            color: AppColors.red,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          TextFormField(
            readOnly: readOnly,
            maxLines: textarea ? 5 : 1,
            initialValue: '${value ?? ''}',
            // key: Key(value.toString()),
            keyboardType:
                numberOnly == true ? TextInputType.number : TextInputType.text,
            onChanged: _onChanged,
            onFieldSubmitted: _onFieldSubmitted,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.lightGrey,
              contentPadding: EdgeInsets.symmetric(
                  vertical: 16.5, horizontal: icon != null ? 0 : 16.5),
              prefixIcon: icon != null ? Icon(icon) : null,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: error?[column] != null
                      ? AppColors.red
                      : AppColors.borderColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(radius),
              ),
              hintText: placeholder,
              hintStyle: TextStyle(color: AppColors.lightDark),
            ),
          ),
        ],
      ),
    );
  }

  _onChanged(v) {
    onChanged(v, column);
  }

  _onFieldSubmitted(value) {
    if (onFieldSubmitted != null) {
      onFieldSubmitted!(value, column);
    }
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
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: TextField(
        onChanged: _onChanged,
        obscureText: showPassword,
        obscuringCharacter: "*",
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.lightGrey,
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
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primary,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: widget.placeholder,
        ),
      ),
    );
  }

  _onChanged(value) {
    widget.onChanged(value, widget.column);
  }

  _togglePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }
}
