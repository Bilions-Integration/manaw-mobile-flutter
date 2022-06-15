import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/image.dart';
import 'package:my_app/model/common_model.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/services/profile_service.dart';

class ProfileImage extends StatelessWidget {
  final Function(User) callback;

  final String? image;

  final auth = Get.find<AuthController>();

  ProfileImage({Key? key, required this.callback, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: _showUploader,
            child: Stack(
              children: [
                borderRadiusCard(
                  100,
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                    child: Container(
                      color: AppColors.white,
                      child: MyImage.network(
                        image ?? '',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  padding: 2,
                  color: AppColors.lightGrey,
                ),
                Positioned(
                  bottom: -5,
                  right: 4,
                  child: borderRadiusCard(
                    20,
                    const Icon(
                      Icons.photo_camera,
                      size: 20,
                    ),
                    border: 0,
                    padding: 2,
                  ),
                )
              ],
            ),
          ),
        ),
        mr(1),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                auth.user.value!.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              mb(0.5),
              Text(
                auth.user.value!.email,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _showUploader() {
    final List<Menu> menuList = [
      Menu(icon: Icons.camera_alt, title: 'camera'.tr, key: 'camera'),
      Menu(icon: Icons.collections, title: 'gallery'.tr, key: 'gallery'),
    ];
    AppWidget.showMenu(
      menuList: menuList,
      height: 150,
      onSelect: (Menu menu) async {
        if (menu.key == 'camera') {
          final MyFile? image =
              await AppWidget.showFileUpload(source: ImageSource.camera);
          if (image == null) {
            return;
          }
          _uploadImage(image);
        } else {
          final MyFile? image =
              await AppWidget.showFileUpload(source: ImageSource.gallery);
          if (image == null) {
            return;
          }
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
