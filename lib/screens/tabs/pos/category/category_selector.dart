import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:my_app/components/common_widget.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/list_picker.dart';
import 'package:my_app/model/common_model.dart';

class CategorySelector extends StatefulWidget {
  final BuildContext context;
  const CategorySelector({Key? key, required this.context}) : super(key: key);
  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final List<ListItem> menuList = [
    ListItem(title: 'Mac book'),
    ListItem(title: 'I phone'),
    ListItem(title: 'Vivo'),
    ListItem(title: 'Vivo'),
    ListItem(title: 'I pad Air'),
    ListItem(title: 'I pad'),
    ListItem(title: 'Snack'),
    ListItem(title: 'New Phone'),
    ListItem(title: 'China Phone'),
    ListItem(title: 'B Phone'),
    ListItem(title: 'D Phone'),
    ListItem(title: 'E Phone'),
    ListItem(title: 'F Phone'),
    ListItem(title: 'My Phone'),
  ];

  ListItem? selectedList;

  _showList() {
    ListPicker(
      onSelect: _onSelect,
      menuList: menuList,
      context: widget.context,
    ).open();
  }

  _onSelect(ListItem data) {
    setState(() {
      selectedList = data;
    });
    FimberLog(data.title);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.dark,
          border: Border(
            top: BorderSide(color: AppColors.white, width: 0.2),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: _showList,
                child: Row(
                  children: [
                    Text(
                      selectedList?.title ?? 'Select Category',
                      style: TextStyle(color: AppColors.white),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
              Row(
                children: const [
                  IconTapper(icon: AppAssets.icSearch),
                  IconTapper(icon: AppAssets.icCart),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
