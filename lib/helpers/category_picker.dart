import 'package:flutter/material.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/model/category_model.dart';

class CategoryPicker {
  final BuildContext context;
  final double? height;
  final String? searchPlaceholder;
  final List<CategoryModel> menuList;
  final Function(CategoryModel) onSelect;
  final Function(String)? onSearch;

  CategoryPicker({
    required this.context,
    required this.menuList,
    this.searchPlaceholder,
    this.onSearch,
    required this.onSelect,
    this.height = 1000,
  });

  void open() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      context: context,
      builder: (builder) {
        return MyListView(
          height: height,
          context: context,
          onSelect: onSelect,
          searchPlaceholder: searchPlaceholder,
          menuList: menuList,
        );
      },
    );
  }
}

// List View Widget
class MyListView extends StatefulWidget {
  final BuildContext context;
  final double? height;
  final List<CategoryModel> menuList;
  final String? searchPlaceholder;
  final Function(CategoryModel) onSelect;
  const MyListView({Key? key, required this.height, this.searchPlaceholder, required this.context, required this.menuList, required this.onSelect})
      : super(key: key);

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List<CategoryModel> chosenList = [];

  @override
  void initState() {
    setState(() {
      chosenList = List.from(widget.menuList);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 30,
          top: 7,
          left: 10,
          right: 10,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 6,
              width: 50,
              child: Container(
                decoration: BoxDecoration(color: AppColors.dark, borderRadius: BorderRadius.circular(10)),
              ),
            ),
            AppWidget.marginBottom(1),
            Padding(
              padding: const EdgeInsets.all(5),
              child: MyTextInput(
                placeholder: widget.searchPlaceholder ?? 'Search',
                icon: Icons.search,
                onChanged: _onSearch,
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: chosenList
                    .map(
                      (CategoryModel item) => Container(
                        decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.all(4),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 20.0,
                          ),
                          dense: true,
                          onTap: () => {_selectModal(item, context)},
                          trailing: const Icon(
                            Icons.radio_button_checked,
                            size: 20,
                          ),
                          title: Text(
                            item.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _selectModal(CategoryModel type, context) {
    Navigator.pop(context);
    widget.onSelect(type);
  }

  _onSearch(String keyword, String? column) {
    final newList = widget.menuList.where((CategoryModel element) {
      final String name = element.name.toLowerCase();
      return name.contains(keyword.toLowerCase());
    }).toList();

    setState(() {
      chosenList = List.from(newList);
    });
  }
}