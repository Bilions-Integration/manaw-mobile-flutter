import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/styles.dart';

customAppBar2({
  required BuildContext context,
  required String title,
  Function()? toggleSearch,
  Function? search,
  Function()? add,
  bool isSearch = false,
  bool showAction = true,
  bool centerTitle = false,
}) {
  return AppBar(
    centerTitle: centerTitle,
    title: titleAndSearchInput(isSearch, title, search),
    backgroundColor: AppColors.primary,
    titleSpacing: 0,
    elevation: 0,
    leading: IconButton(
      icon: SvgPicture.asset(AppAssets.leftArrow,
          width: 23, height: 23, color: AppColors.white),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: showAction
        ? [
            openAndCloseSearch(isSearch, toggleSearch),
            if (add != null)
              IconButton(
                icon: SvgPicture.asset(AppAssets.plus,
                    width: 17, height: 17, color: AppColors.white),
                onPressed: add,
              ),
          ]
        : [],
  );
}

Widget openAndCloseSearch(isSearch, toggleSearch) {
  return isSearch
      ? IconButton(
          icon: const Icon(Icons.clear, size: 20),
          onPressed: toggleSearch,
        )
      : IconButton(
          icon: SvgPicture.asset(AppAssets.search,
              width: 20, height: 20, color: AppColors.white),
          onPressed: toggleSearch,
        );
}

Widget titleAndSearchInput(isSearch, title, search) {
  return isSearch
      ? TextFormField(
          style: Styles.t2Light,
          onFieldSubmitted: (value) => search(value),
          decoration: const InputDecoration(border: InputBorder.none),
          cursorColor: AppColors.white,
          autofocus: true,
        )
      : Text(title, style: Styles.t2Light);
}
