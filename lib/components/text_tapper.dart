import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';

class TextTapper extends StatelessWidget {
  final String title;

  final Color? color;

  final Function() onTab;

  const TextTapper(
      {Key? key, required this.title, required this.onTab, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        title,
        style: TextStyle(color: color ?? AppColors.primary),
      ),
      onTap: onTab,
    );
  }
}
