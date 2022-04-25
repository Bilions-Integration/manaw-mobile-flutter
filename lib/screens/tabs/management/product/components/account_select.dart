import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/account_picker.dart';
import 'package:my_app/components/common_widget.dart';
import 'package:my_app/model/account_model/account_model.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/screens/tabs/pos/cart_controller.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/components/category_picker.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/services/account_service.dart';
import 'package:my_app/services/category_service.dart';

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
        menuList = accounts;
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
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      child: Material(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.dark,
            border: Border(
              top: BorderSide(color: AppColors.white, width: 0.2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _showList,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Text(
                          selectedList?.bankName ?? 'Select Category',
                          style: TextStyle(color: AppColors.white),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          AppAssets.icSearch,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _showCheckout() {
    Get.to(() => RouteName.checkoutScreen);
  }
}
