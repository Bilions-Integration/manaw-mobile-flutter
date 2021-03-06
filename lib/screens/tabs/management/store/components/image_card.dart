import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/image.dart';
import 'package:my_app/model/common_model.dart';

class ImageCard extends StatefulWidget {
  final Function(MyFile, String) callback;
  final String? logo;
  final String? banner;

  const ImageCard({Key? key, this.logo, this.banner, required this.callback})
      : super(key: key);

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  File? pickedLogo;
  File? pickedBanner;

  Widget bannerWidget() {
    return InkWell(
      onTap: () {
        _showUploader('banner');
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: pickedBanner != null
              ? Image.file(pickedBanner!,
                  width: double.infinity, height: 180, fit: BoxFit.cover)
              : widget.banner != null
                  ? MyImage.network(widget.banner!,
                      width: double.infinity, height: 180, fit: BoxFit.cover)
                  : Stack(
                      children: [
                        Container(
                          height: 180,
                          width: double.infinity,
                          color: Colors.grey[200],
                        ),
                        Positioned(
                          top: 80,
                          left: 0,
                          right: 0,
                          child: Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                const Text('Upload'),
                                mr(0.5),
                                borderRadiusCard(10,
                                    const Icon(Icons.photo_camera, size: 20))
                              ])),
                        )
                      ],
                    )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: Stack(children: [
            bannerWidget(),
            logoWidget(),
          ]),
        ),
        mb(1)
      ],
    );
  }

  Widget logoWidget() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Center(
        child: InkWell(
          onTap: () {
            _showUploader('logo');
          },
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
                    child: pickedLogo != null
                        ? Image.file(
                            pickedLogo!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : MyImage.network(
                            widget.logo ?? '',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                padding: 2,
                color: AppColors.lightGrey,
              ),
              Positioned(
                bottom: -3,
                right: 10,
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
    );
  }

  _showUploader(String type) {
    final List<Menu> menuList = [
      Menu(icon: Icons.camera_alt, title: 'Camera', key: 'camera'),
      Menu(icon: Icons.collections, title: 'Gallery', key: 'gallery'),
    ];
    AppWidget.showMenu(
      menuList: menuList,
      height: 150,
      onSelect: (Menu menu) async {
        final MyFile? image = (menu.key == 'camera')
            ? await AppWidget.showFileUpload(source: ImageSource.camera)
            : await AppWidget.showFileUpload(source: ImageSource.gallery);
        if (image == null) return;
        _uploadImage(image, type);
      },
    );
  }

  _uploadImage(MyFile image, String type) async {
    setState(() {
      if (type == 'logo') {
        pickedLogo = image.file;
      } else {
        pickedBanner = image.file;
      }
    });
    widget.callback(image, type);
  }
}
