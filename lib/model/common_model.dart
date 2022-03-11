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
}

class ListItem {
  final String title;
  final dynamic id;
  ListItem({required this.title, this.id});
}

class Account {
  final String name;
  final int id;
  final dynamic currentBalance;
  Account({
    required this.name,
    required this.id,
    required this.currentBalance,
  });

  Account.fromJson(Map json)
      : id = json['id'],
        name = json['owner_name'],
        currentBalance = json['current_balance'];

  Map<String, dynamic> toJson() => {
        'owner_name': name,
        'id': id,
        'current_Balance': currentBalance,
      };
}
