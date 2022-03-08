import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/model/common_model.dart';

class AppWidget {
  static marginBottom(double value) {
    return Padding(padding: EdgeInsets.only(bottom: value * 10));
  }

  static hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static storeToken(String? token) {
    final box = GetStorage();
    box.write('@bearerToken', token);
  }

  static fileUpload({ImageSource source = ImageSource.gallery}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    final file =
        await MultipartFile.fromFile(image!.path, filename: image.name);
    return MyFile(blob: file, path: image.path, name: image.name);
  }

  showErrorMessageDialog(
      {required BuildContext context, required String message}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(title: Text(message)),
    );
  }

  static void showMenu(
      {required BuildContext context,
      required List<Menu> menuList,
      required double height,
      required Function onSelect}) {
    void _selectModal(type, context) {
      Navigator.pop(context);
      onSelect(type);
    }

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (builder) {
          return SizedBox(
            height: height,
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
                            onTap: () => {_selectModal(item.key, context)},
                            title: Text(item.title),
                            leading: Icon(item.icon),
                          ),
                  )
                  .toList(),
            ),
          );
        });
  }
}
