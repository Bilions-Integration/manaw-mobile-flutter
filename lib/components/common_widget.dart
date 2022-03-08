import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/data/colors.dart';

class IconTapper extends StatelessWidget {
  final String icon;

  final Function()? onTap;

  const IconTapper({Key? key, required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: InkWell(
        hoverColor: Colors.blue,
        onTap: onTap,
        child: SvgPicture.asset(
          icon,
          color: AppColors.white,
        ),
      ),
    );
  }
}
