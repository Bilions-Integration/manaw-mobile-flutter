import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/image_preview.dart';
import 'package:my_app/components/index.dart';
import 'package:my_app/model/common_model.dart';

class PosScreen extends StatefulWidget {
  const PosScreen({Key? key}) : super(key: key);

  @override
  State<PosScreen> createState() => _PosScreenState();
}

class _PosScreenState extends State<PosScreen> {
  var selectedImage;

  @override
  void initState() {
    _getFirebaseToken();
    super.initState();
  }

  _getFirebaseToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    String? token = await messaging.getToken();
    print('FCM_TOKEN $token');
  }

  void _showModal() {
    final List<Menu> menuList = [
      Menu(icon: Icons.edit, title: 'Edit', key: 'edit'),
      Menu(icon: Icons.delete, title: 'Delete', key: 'delete'),
      Menu(icon: Icons.copy, title: 'Copy', key: 'copy'),
    ];
    AppWidget.showMenu(
        context: context,
        menuList: menuList,
        onSelect: _onMenuSelect,
        height: 250);
  }

  void _onMenuSelect(data) {
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        PrimaryButton(value: 'Select Image', onPressed: _selectImage),
        const Text('Uploaded Image'),
        selectedImage != null
            ? ImagePreview(
                image: selectedImage,
                height: 100,
              )
            : const Text('No File')
      ]),
    );
  }

  _selectImage() async {
    try {
      final MyFile image =
          await AppWidget.fileUpload(source: ImageSource.gallery);

      setState(() {
        selectedImage = image.path;
      });
      // print(image.path);
      // var formData = FormData.fromMap({'name': 'AJ', 'avatar': image.path});
      // var response = await Dio()
      //     .post('http://192.168.1.105:8000/api/file_upload', data: formData);

      // print(response.data);
    } catch (e) {
      print(e);
    }
  }
}
