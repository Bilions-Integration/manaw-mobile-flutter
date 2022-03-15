import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/common_model.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/services/profile_service.dart';

class ProfileImage extends StatelessWidget {
  final Function(User) callback;

  final String? image;

  ProfileImage({Key? key, required this.callback, this.image}) : super(key: key);

  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: _showUploader,
          child: Stack(children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(image ?? ''),
            ),
            Positioned(
              bottom: -5,
              right: 4,
              child: borderRadiusCard(
                  10,
                  const Icon(
                    Icons.photo_camera,
                    size: 20,
                  ),
                  border: 2),
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

  _showUploader() {
    final List<Menu> menuList = [
      Menu(icon: Icons.camera_alt, title: 'Camera', key: 'camera'),
      Menu(icon: Icons.collections, title: 'Gallery', key: 'gallery'),
    ];
    AppWidget.showMenu(
      menuList: menuList,
      height: 150,
      onSelect: (Menu menu) async {
        if (menu.key == 'camera') {
          final MyFile image = await AppWidget.showFileUpload(source: ImageSource.camera);
          _uploadImage(image);
        } else {
          final MyFile image = await AppWidget.showFileUpload(source: ImageSource.gallery);
          _uploadImage(image);
        }
      },
    );
  }

  _uploadImage(MyFile image) async {
    var res = await ProfileService.setImage(image);
    final User newUser = auth.user.value!;
    newUser.image = res['data'];
    auth.user.value = newUser;
    callback(newUser);
  }
}
