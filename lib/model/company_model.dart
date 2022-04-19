import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class Company {
  final int id;
  final String? name;
  final String? currency;
  final String? address;
  final Color? color;
  String? hexColor;
  final String? logo;
  final num tax;

  Company({
    required this.id,
    this.name,
    this.currency,
    this.color,
    required this.tax,
    this.hexColor,
    this.logo,
    this.address,
  });

  Company.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        color = HexColor(json['color']),
        hexColor = json['color'],
        address = json['address'],
        tax = json['tax'] ?? 0,
        logo = json['logo'],
        currency = getCurrency(json['currency']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'tax': tax,
        'address': address,
        'currencySymbol': currency,
        'logo': logo,
        'color': hexColor,
      };
}

String getCurrency(String code) {
  var format =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: code);
  return format.currencySymbol;
}
