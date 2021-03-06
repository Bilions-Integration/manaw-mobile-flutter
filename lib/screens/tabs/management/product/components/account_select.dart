import 'package:flutter/material.dart';
import 'package:my_app/components/account_picker.dart';
import 'package:my_app/model/account_model/account_model.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/services/account_service.dart';

class AccountSelector extends StatefulWidget {
  final Function(AccountModel) callback;
  const AccountSelector({
    Key? key,
    required this.callback,
  }) : super(key: key);
  @override
  State<AccountSelector> createState() => _AccountSelectorState();
}

class _AccountSelectorState extends State<AccountSelector> {
  List<AccountModel> menuList = [];

  AccountModel? selectedList;

  _getCategory() async {
    if (menuList.isEmpty) {
      var res = await AccountService.get({'page': 1, 'limit': 10});
      List<AccountModel> accounts = res['data'];
      setState(() {
        menuList = accounts.where((element) => element.id != 0).toList();
      });
    }
  }

  _showList() async {
    await _getCategory();
    AccountPicker(
      onSelect: _onSelect,
      menuList: menuList,
    ).open();
  }

  _onSelect(AccountModel data) {
    setState(() {
      selectedList = data;
    });
    widget.callback(data);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.borderColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: _showList,
        child: Container(
          height: 50,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedList?.ownerName ?? 'Select Account',
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
