import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

List<Widget> checkoutActions() {
  return [
    IconButton(
      icon: SvgPicture.asset(
        AppAssets.icAccount,
        color: AppColors.white,
      ),
      onPressed: () => {_showAccountModal()},
    ),
    IconButton(
      icon: SvgPicture.asset(
        AppAssets.icCoupon,
        color: AppColors.white,
      ),
      onPressed: () => {_showCouponModal()},
    ),
    Padding(
      padding: const EdgeInsets.only(right: 10),
      child: IconButton(
        icon: SvgPicture.asset(
          AppAssets.icPerson,
          color: AppColors.white,
        ),
        onPressed: () => {_showCustomerModal()},
      ),
    ),
  ];
}

_showCouponModal() {
  alert();
}

_showAccountModal() {
  // final List accountList = [];

  // _onSelect(item) {}

  // AccountPicker(
  //   onSelect: _onSelect,
  //   menuList: accountList,
  //   context: widget.context,
  // ).open();
}

_showCustomerModal() {
  alert();
}
