import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/data/assets.dart';

void actionPopup({
  int? id, 
  required dynamic category,
  required BuildContext context,
  required Function(int? id) edit,
  required Future<dynamic> Function(int? id) delete
}) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top : Radius.circular(20)
      )
    ),
    context : context ,
    builder : (BuildContext context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.18,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              icon : SvgPicture.asset(AppAssets.edit,width: 18, height: 18),
              label : const Text('Edit'),
              onPressed: () {
                Navigator.pop(context);
                edit(id);
              },
            ),
            // const SizedBox(height: 5),
            TextButton.icon(
              icon : SvgPicture.asset(
                AppAssets.trash,
                width: 18,
                height: 18,
              ),
              label : const Text(
                'Delete',
                style: TextStyle(
                  color : Color(0xffED1C24),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                delete(id);
                category.remove();
              },
            ),
          ],
        )
      )
    )
  );
}
