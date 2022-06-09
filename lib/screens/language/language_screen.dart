import 'package:flutter/material.dart';
// 📦 Package imports:
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:

import '../../data/colors.dart';
import '../../helpers/helper.dart';
import 'locale_helper.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<Language> languages = [
    Language(name: "English", locale: const Locale('en')),
    Language(name: "မြန်မာ", locale: const Locale('my')),
  ];
  late Language selectedLanguage;
  var langController = Get.find<LanguageController>();
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Language'),
      ),
      body: Column(
        children: [
          mb(0.7),
          ...languages.map(
            (e) => Column(
              children: [
                InkWell(
                  onTap: () => _updateLocale(e),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Text(
                          e.name,
                          style: TextStyle(
                            color: selectedLanguage == e
                                ? AppColors.primary
                                : AppColors.black,
                          ),
                        ),
                        const Spacer(),
                        if (selectedLanguage == e)
                          const Icon(Icons.check_rounded)
                      ],
                    ),
                  ),
                ),
                hr(),
                mb(0.7),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedLanguage = languages.firstWhere(
          (element) => element.locale == langController.locale.value);
    });
    SharedPreferences.getInstance().then((value) {
      setState(() {
        prefs = value;
      });
    });
  }

  _updateLocale(Language e) async {
    setState(() {
      selectedLanguage = e;
    });
    langController.locale.value = e.locale;
    Get.updateLocale(e.locale);
    prefs.setString(prefKeyLocale, e.locale.languageCode);
  }
}
