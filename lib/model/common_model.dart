import 'package:flutter/material.dart';

class Menu {
  final IconData icon;
  final String title;
  final String key;
  final String? subTitle;
  Menu(
      {required this.icon,
      required this.title,
      required this.key,
      this.subTitle});
}
