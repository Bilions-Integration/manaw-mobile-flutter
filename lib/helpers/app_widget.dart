import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/common_model.dart';

class AppWidget {
  static marginBottom(double value) {
    return Padding(padding: EdgeInsets.only(bottom: value * 10));
  }

  static storeToken(String? token) {
    final box = GetStorage();
    box.write('@bearerToken', token);
  }

  static showFileUpload({ImageSource source = ImageSource.gallery}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) {
      return null;
    }
    final blob = await MultipartFile.fromFile(image.path, filename: image.name);
    return MyFile(blob: blob, path: image.path, name: image.name);
  }

  static void showMenu(
      {required List<Menu> menuList,
      double height = 1000,
      required Function(Menu) onSelect}) {
    void _selectModal(type, context) {
      Navigator.pop(context);
      onSelect(type);
    }

    final context = currentContext();
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (builder) {
        return SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 10),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: menuList
                  .map(
                    (Menu item) => item.subTitle != null
                        ? ListTile(
                            onTap: () => {_selectModal(item.key, context)},
                            title: Text(item.title),
                            subtitle: Text(item.subTitle!),
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Icon(item.icon),
                            ),
                          )
                        : ListTile(
                            onTap: () => {_selectModal(item, context)},
                            title: Text(item.title),
                            leading: Icon(item.icon),
                          ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
