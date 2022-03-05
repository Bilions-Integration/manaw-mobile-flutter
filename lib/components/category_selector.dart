import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: AppColors.darkRed,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 3,
              blurRadius: 4,
              offset: Offset(0, 1), // changes position of shadow
            )
          ],
          border:
              Border(top: BorderSide(color: HexColor('#E6E6E6'), width: 1))),
    );
  }
}
