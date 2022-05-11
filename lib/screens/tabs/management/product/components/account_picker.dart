import 'package:flutter/material.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/app_widget.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/model/account_model/account_model.dart';

class AccountPicker {
  final double? height;
  final String? searchPlaceholder;
  final List<AccountModel> menuList;
  final Function(AccountModel) onSelect;
  final Function(String)? onSearch;

  AccountPicker({
    required this.menuList,
    this.searchPlaceholder,
    this.onSearch,
    required this.onSelect,
    this.height = 1000,
  });

  void open() {
    final context = currentContext();
    showModalBottomSheet(
      shape: Styles.topOnlyBorderRadius(15),
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).size.height - 150,
          padding: MediaQuery.of(context).viewInsets,
          child: MyListView(
            context: context,
            onSelect: onSelect,
            searchPlaceholder: searchPlaceholder,
            menuList: menuList,
          ),
        );
      },
    );
  }
}

// List View Widget
class MyListView extends StatefulWidget {
  final BuildContext context;
  final List<AccountModel> menuList;
  final String? searchPlaceholder;
  final Function(AccountModel) onSelect;
  const MyListView({
    Key? key,
    this.searchPlaceholder,
    required this.context,
    required this.menuList,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List<AccountModel> chosenList = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10)),
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
                    (AccountModel item) => Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(10)),
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
                          item.ownerName,
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
    );
  }

  @override
  void initState() {
    setState(() {
      chosenList = List.from(widget.menuList);
    });
    super.initState();
  }

  _onSearch(String keyword, String? column) {
    final newList = widget.menuList.where((AccountModel element) {
      final String name = element.ownerName.toLowerCase();
      return name.contains(keyword.toLowerCase());
    }).toList();

    setState(() {
      chosenList = List.from(newList);
    });
  }

  _selectModal(AccountModel type, context) {
    Navigator.pop(context);
    widget.onSelect(type);
  }
}
