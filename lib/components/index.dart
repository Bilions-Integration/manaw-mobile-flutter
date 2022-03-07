import 'package:flutter/material.dart';
import 'package:my_app/model/common_model.dart';

class AppWidget {
  showErrorMessageDialog(
      {required BuildContext context, required String message}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(title: Text(message)),
    );
  }

  static void showMenu(
      {required BuildContext context,
      required List<Menu> menuList,
      required double height,
      required Function onSelect}) {
    void _selectModal(type, context) {
      Navigator.pop(context);
      onSelect(type);
    }

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (builder) {
          return SizedBox(
            height: height,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: menuList
                  .map(
                    (Menu item) => item.subTitle != null
                        ? ListTile(
                            onTap: () => {_selectModal(item.key, context)},
                            title: Text(item.title),
                            subtitle: Text(item.subTitle!),
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Icon(item.icon),
                            ),
                          )
                        : ListTile(
                            onTap: () => {_selectModal(item.key, context)},
                            title: Text(item.title),
                            leading: Icon(item.icon),
                          ),
                  )
                  .toList(),
            ),
          );
        });
  }
}
