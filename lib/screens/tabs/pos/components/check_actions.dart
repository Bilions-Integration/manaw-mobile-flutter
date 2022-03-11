import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/components/prompt.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/components/account_picker.dart';
import 'package:my_app/components/customer_picker.dart';
import 'package:my_app/model/account_model.dart';
import 'package:my_app/model/customer_model.dart';
import 'package:my_app/screens/tabs/pos/cart_controller.dart';
import 'package:my_app/services/account_service.dart';
import 'package:my_app/services/customer_service.dart';

List<Widget> checkoutActions() {
  return [
    IconButton(
      icon: SvgPicture.asset(
        AppAssets.icAccount,
        color: AppColors.white,
      ),
      onPressed: () => {showAccountModal()},
    ),
    IconButton(
      icon: SvgPicture.asset(
        AppAssets.icCoupon,
        color: AppColors.white,
      ),
      onPressed: () => {showCouponModal()},
    ),
    Padding(
      padding: const EdgeInsets.only(right: 10),
      child: IconButton(
        icon: SvgPicture.asset(
          AppAssets.icPerson,
          color: AppColors.white,
        ),
        onPressed: () => {showCustomerModal()},
      ),
    ),
  ];
}

showCouponModal() {
  final cartController = Get.find<CartController>();

  _onSubmit(String? value) {
    cartController.discount.value = value;
  }

  prompt(
    onSubmit: _onSubmit,
    title: 'Discount Amount',
    confirmText: 'Submit',
    value: cartController.discount.value,
    numberOnly: true,
  );
}

showAccountModal({Function()? callback}) async {
  final cartController = Get.find<CartController>();
  List<Account> accounts = await AccountService.get();
  _onSelect(Account account) {
    cartController.account.value = account;
    final box = GetStorage();
    box.write('@account', jsonEncode(account.toJson()));
    callback != null ? callback() : null;
  }

  AccountPicker(
    onSelect: _onSelect,
    selectedAccount: cartController.account.value,
    menuList: accounts,
  ).open();
}

showCustomerModal() async {
  final cartController = Get.find<CartController>();
  _onSelect(CustomerModel customer) {
    cartController.customer.value = customer;
  }

  List<CustomerModel> customers = await CustomerService.get();
  CustomerPicker(
    onSelect: _onSelect,
    selectedCustomer: cartController.customer.value,
    menuList: customers,
  ).open();
}
