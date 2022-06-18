import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

prompt({
  String? title,
  dynamic value,
  String? confirmText,
  String? placeholder,
  String? cancelText,
  bool? numberOnly,
  double? height,
  bool textarea = false,
  required Function(String?) onSubmit,
  IconData? icon,
  Widget? iconWidget,
}) {
  final context = currentContext();
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => PromptWidget(
      onSubmit: onSubmit,
      confirmText: confirmText,
      cancelText: cancelText,
      numberOnly: numberOnly,
      textarea: textarea,
      icon: icon,
      value: value,
      placeholder: placeholder,
      title: title,
      height: height,
      iconWidget: iconWidget,
    ),
  );
}

class PromptWidget extends StatefulWidget {
  final String? title;
  final dynamic value;
  final String? confirmText;
  final String? placeholder;
  final String? cancelText;
  final Function(String?) onSubmit;
  final bool? numberOnly;
  final bool textarea;
  final IconData? icon;
  final double? height;
  final Widget? iconWidget;

  const PromptWidget({
    Key? key,
    this.value,
    this.textarea = false,
    this.height,
    required this.title,
    this.confirmText,
    required this.icon,
    this.placeholder,
    this.cancelText,
    this.numberOnly = false,
    required this.onSubmit,
    this.iconWidget,
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
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title ?? 'Prompt',
              style: TextStyle(color: AppColors.black, fontSize: 18),
            ),
            mb(2),
            MyTextInput(
              icon: widget.icon,
              iconWidget: widget.iconWidget,
              placeholder: widget.placeholder ?? '',
              onChanged: _inputChanged,
              value: widget.value,
              textarea: widget.textarea,
              numberOnly: widget.numberOnly,
            ),
            mb(2),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => {Navigator.pop(context)},
                  child: Text((widget.cancelText ?? 'cancel'.tr).toUpperCase()),
                ),
                mr(3),
                PrimaryButton(
                  value: widget.confirmText ?? 'confirm'.tr,
                  onPressed: () {
                    widget.onSubmit(inputValue);
                    Navigator.pop(context);
                  },
                  width: 100,
                  height: 40,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _inputChanged(String? data, String? column) {
    setState(() {
      inputValue = data;
    });
  }
}
