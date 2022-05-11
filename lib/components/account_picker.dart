import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/account_model/account_model.dart';
import 'package:my_app/screens/tabs/management/account/account_create_and_edit.dart';

class AccountPicker {
  final double? height;
  final String? searchPlaceholder;
  final List<AccountModel> menuList;
  final Function(AccountModel) onSelect;
  final AccountModel? selectedAccount;

  AccountPicker({
    required this.menuList,
    required this.onSelect,
    this.searchPlaceholder,
    this.selectedAccount,
    this.height = 1000,
  });

  void open() {
    final context = currentContext();
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      context: context,
      builder: (builder) {
        return menuList.isNotEmpty
            ? MyListView(
                height: height,
                context: context,
                onSelect: onSelect,
                selectedAccount: selectedAccount,
                searchPlaceholder: searchPlaceholder,
                menuList: menuList,
              )
            : Container(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "You don't have an account yet",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'Please create one to proceed.',
                        style: TextStyle(color: AppColors.lightDark),
                      ),
                      mb(0.8),
                      PrimaryButton(
                          value: "Create Account",
                          onPressed: () {
                            Get.to(() => const AccountCreateAndEdit());
                          }),
                    ],
                  ),
                ));
      },
    );
  }
}

// List View Widget
class MyListView extends StatefulWidget {
  final BuildContext context;
  final double? height;
  final AccountModel? selectedAccount;
  final List<AccountModel> menuList;
  final String? searchPlaceholder;
  final Function(AccountModel) onSelect;

  const MyListView({
    Key? key,
    required this.height,
    required this.onSelect,
    required this.context,
    required this.menuList,
    this.selectedAccount,
    this.searchPlaceholder,
  }) : super(key: key);

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List<AccountModel> chosenList = [];

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
                decoration: BoxDecoration(
                    color: AppColors.dark,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            mb(1),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: chosenList
                    .map(
                      (AccountModel item) => Container(
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.all(4),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 20.0,
                          ),
                          dense: true,
                          onTap: () => {_selectModal(item, context)},
                          trailing: widget.selectedAccount?.id == item.id
                              ? Icon(Icons.radio_button_checked,
                                  size: 20, color: AppColors.green)
                              : const Icon(Icons.radio_button_checked,
                                  size: 20),
                          title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.ownerName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Balance # ${currency()} ${cast(item.currentBalance ?? 0)} ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                  ),
                                ),
                              ]),
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

  @override
  void initState() {
    setState(() {
      chosenList = List.from(widget.menuList);
    });
    super.initState();
  }

  _selectModal(AccountModel account, context) {
    Navigator.pop(context);
    widget.onSelect(account);
  }
}
