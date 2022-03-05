import 'package:flutter/material.dart';
import 'package:my_app/components/category_selector.dart';
import 'package:my_app/components/index.dart';
import 'package:my_app/components/button.dart';
import 'package:dio/dio.dart';
import 'package:my_app/model/common_model.dart';
import 'package:my_app/model/flags_model.dart';

class BodyApp extends StatefulWidget {
  const BodyApp({Key? key}) : super(key: key);

  @override
  State<BodyApp> createState() => _BodyAppState();
}

class _BodyAppState extends State<BodyApp> {
  List<Flag> flags = <Flag>[];

  List<Menu> menuList = [
    Menu(const Icon(Icons.edit), 'Edit', 'edit'),
    Menu(const Icon(Icons.delete), 'Delete', 'delete'),
    Menu(const Icon(Icons.copy), 'Copy', 'copy'),
  ];

  @override
  void initState() {
    getHttp();
    super.initState();
  }

  void _linkDetail() {}

  Future<dynamic> getHttp() async {
    try {
      var response = await Dio().get(
          'https://dev-api.trueprotection.co.th/api/flags?authorization=12345878');
      final json = response.data['data'];
      final list = FlagList.fromJson(json);
      setState(() {
        flags = list.flags;
      });
    } catch (e) {
      print(e);
    }
  }

  void _showModal() {
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
    return Column(children: [
      const CategorySelector(),
      PrimaryButton(
        value: 'My Button',
        delete: () => {_linkDetail()},
      ),
      Expanded(
        child: ListView.builder(
            itemCount: flags.length,
            itemBuilder: (context, index) {
              return Text(flags[index].name);
            }),
      ),
      PrimaryButton(
        value: 'My Button',
        delete: () => {_showModal()},
      )
    ]);
  }
}
