import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

class ProfileMenu extends StatelessWidget {
  final Widget icon;
  final String title;
  final String? value;
  final Widget? screen;
  final Function()? onPressed;

  const ProfileMenu({
    Key? key,
    required this.icon,
    required this.title,
    this.value,
    this.screen,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed != null ? onPressed!() : null;
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 3, right: 3),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [icon, mr(1), Text(title)],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        value ?? '',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SvgPicture.asset(AppAssets.icArrowRight),
                  ],
                ),
              )
            ],
          ),
          width: double.infinity,
          height: 50,
          margin: const EdgeInsets.only(bottom: 0),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.line, width: 0.5)),
          ),
        ),
      ),
    );
  }
}
