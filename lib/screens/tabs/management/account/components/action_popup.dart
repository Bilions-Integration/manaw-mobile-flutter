import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';

class ActionPopup extends StatelessWidget {
  const ActionPopup({
    Key? key, 
    required this.id,
    required this.edit, 
    required this.delete, 
  }) : super(key: key);

  final int id;
  final Function(int id) edit;
  final Function(int id) delete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          icon : SvgPicture.asset(AppAssets.edit,width: 18, height: 18, color: AppColors.dark),
          label : const Text('Edit'),
          onPressed: () {
            Navigator.pop(context);
            edit(id);
          },
        ),  // const SizedBox(height: 5),
        TextButton.icon(
          icon : SvgPicture.asset(
            AppAssets.trash,
            width: 18,
            height: 18,
          ),
          label : const Text('Delete', style: TextStyle(
            color : Color(0xffED1C24),
          )),
          onPressed: () {
            Navigator.pop(context);
            delete(id);
          },
        ),
      ],
    );
  }
}