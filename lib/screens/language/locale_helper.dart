import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language {
  String name;
  Locale locale;
  Language({required this.name, required this.locale});
}

class LanguageController extends GetxController {
  var locale = Rx<Locale>(const Locale('en'));
}

const String prefKeyLocale = 'manawstore-locale';
