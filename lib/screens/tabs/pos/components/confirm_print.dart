import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

confirmPrintDialog({
  String? title,
  String? message,
  String? confirmText,
  String? cancelText,
  required Function(bool) onPressed,
  required Function() onDownload,
}) {
  final context = currentContext();
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actionsPadding: const EdgeInsets.all(10),
      contentPadding:
          const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
      title: Row(children: [
        const Icon(Icons.info),
        mr(1),
        Text(
          title ?? 'Info',
          style: TextStyle(color: AppColors.black, fontSize: 17),
        )
      ]),
      content: Text(
        message ?? '',
        style: TextStyle(color: AppColors.black, fontSize: 14),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () => {onPressed(false), Navigator.pop(context)},
              child: Text(cancelText ?? 'CANCEL',
                  style: const TextStyle(fontSize: 13)),
            ),
            mr(1),
            PrimaryButton(
              value: '',
              child: Icon(
                Icons.download_rounded,
                color: AppColors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                onDownload();
              },
              width: 40,
              height: 40,
            ),
            mr(1),
            PrimaryButton(
              value: confirmText ?? 'CONFIRM',
              onPressed: () {
                Navigator.pop(context);
                onPressed(true);
              },
              width: 100,
              height: 40,
            ),
          ],
        ),
      ],
    ),
  );
}
