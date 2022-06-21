import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/data/colors.dart';

String getCurrency(String code) {
  var format =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: code);
  return format.currencySymbol;
}

class Company {
  final int id;
  final String? name;
  final String? currency;
  final String? address;
  final Color? color;
  String? hexColor;
  final String? logo;
  final num tax;
  final String? banner;
  final num? taxId;
  final num? wht;
  final String? purchaseInvPrefix;
  final String? saleInvPrefix;
  final String? type;
  final String? email;
  final String? phone;
  final String? referralCode;

  Company({
    required this.id,
    this.name,
    this.currency,
    this.color,
    required this.tax,
    this.hexColor,
    this.logo,
    this.address,
    this.banner,
    this.taxId,
    this.wht,
    this.purchaseInvPrefix,
    this.saleInvPrefix,
    this.type,
    this.email,
    this.phone,
    this.referralCode,
  });

  Company.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        color = HexColor(json['color']),
        hexColor = json['color'],
        address = json['address'],
        tax = json['tax'] ?? 0,
        logo = json['logo'],
        currency = getCurrency(json['currency']),
        banner = json['banner'],
        taxId = json['tax_id'] as num?,
        wht = json['wht'] ?? 0,
        purchaseInvPrefix = json['purchase_inv_prefix'] as String?,
        saleInvPrefix = json['sale_inv_prefix'] as String?,
        type = json['type'] as String?,
        email = json['email'] as String?,
        referralCode = json['referral_code'] as String?,
        phone = json['phone'] as String?;

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'tax': tax,
        'address': address,
        'currencySymbol': currency,
        'logo': logo,
        'color': hexColor,
        'banner': banner,
        'tax_id': taxId,
        'wht': wht,
        'purchase_inv_prefix': purchaseInvPrefix,
        'sale_inv_prefix': saleInvPrefix,
        'referral_code': referralCode,
        'type': type,
        'email': email,
        'phone': phone
      };
}
