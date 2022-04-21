import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/data/colors.dart';

class PopupItem extends StatelessWidget {
  final String icon;
  final String name;
  const PopupItem({
    Key? key,
    required this.icon,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: AppColors.borderColor, width: 1),
          ),
          child: SizedBox(
            width: 25,
            height: 25,
            child: SvgPicture.asset(icon),
          ),
        ),
        const SizedBox(
          width: 1,
          height: 8,
        ),
        Text(name),
      ],
    );
  }
}
