import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/helpers/helper.dart';

class ProfileImage extends StatelessWidget {
  ProfileImage({Key? key}) : super(key: key);

  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {},
          child: Stack(children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(auth.user.value!.image),
            ),
            const Positioned(
              bottom: 0,
              right: 4,
              child: Icon(Icons.photo_camera),
            )
          ]),
        ),
      ),
      Text(
        auth.user.value!.name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      mb(2)
    ]);
  }
}
