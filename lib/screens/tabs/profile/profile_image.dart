import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

class ProfileImage extends StatelessWidget {
  ProfileImage({Key? key}) : super(key: key);

  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(auth.user.value!.image),
        ),
      ),
      Text(
        auth.user.value!.name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      PrimaryButton(
        child: SizedBox(
          width: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Edit Profile',
                style: TextStyle(color: AppColors.white, fontSize: 13),
              ),
              SvgPicture.asset(
                AppAssets.icArrowRight,
                color: AppColors.white,
              )
            ],
          ),
        ),
        value: '',
        width: 100,
        onPressed: () {},
        height: 30,
      ),
      mb(4)
    ]);
  }
}
