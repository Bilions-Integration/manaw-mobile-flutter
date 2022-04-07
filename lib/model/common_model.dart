import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Menu {
  final IconData icon;
  final String title;
  final String key;
  final String? subTitle;
  Menu({
    required this.icon,
    required this.title,
    required this.key,
    this.subTitle,
  });
}

class MyFile {
  final MultipartFile blob;
  final String path;
  final String name;
  MyFile({
    required this.blob,
    required this.path,
    required this.name,
  });

  @override
  String toString() {
    // TODO: implement toString
    return 'Path: ' + path + ", Name : " + name;
  }
}

class ListItem {
  final String title;
  final dynamic id;
  ListItem({required this.title, this.id});
}
