import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

confirmPopup({
  String? title,
  String? confirmText,
  String? cancelText,
  String? description,
  Color? confirmColor,
  required Function(bool) onSubmit,
}) {
  final context = currentContext();
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => PromptWidget(
      onSubmit: onSubmit,
      confirmText: confirmText,
      cancelText: cancelText,
      title: title,
      description: description,
      confirmColor: confirmColor,
    ),
  );
}

class PromptWidget extends StatefulWidget {
  final String? title;
  final String? confirmText;
  final String? cancelText;
  final Function(bool) onSubmit;
  final String? description;
  final Color? confirmColor;

  const PromptWidget({
    Key? key,
    this.description,
    required this.title,
    this.confirmText,
    this.cancelText,
    this.confirmColor,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<PromptWidget> createState() => _PromptWidgetState();
}

class _PromptWidgetState extends State<PromptWidget> {
  String? inputValue;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      insetPadding: const EdgeInsets.all(35),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(widget.title ?? 'Are you Sure?'),
                // header(
                //   widget.title ?? '',
                //   factor: 0.9,
                //   align: TextAlign.center,
                // ),
                mb(1),
                SizedBox(
                  width: 200,
                  child: Text(
                    widget.description ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
          hr(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  widget.onSubmit(false);
                  Navigator.pop(context);
                },
                child: Container(
                  width: 150,
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    widget.cancelText ?? 'Cancel',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 50,
                color: AppColors.borderColor,
              ),
              InkWell(
                onTap: () {
                  widget.onSubmit(true);
                  Navigator.pop(context);
                },
                child: Container(
                  width: 150,
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    widget.confirmText ?? 'Confirm',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: widget.confirmColor ?? AppColors.primary,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
