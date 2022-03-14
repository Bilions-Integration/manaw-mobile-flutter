import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

prompt({
  String? title,
  dynamic value,
  String? confirmText,
  String? cancelText,
  bool? numberOnly,
  required Function(String?) onSubmit,
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
      value: value,
      title: title,
    ),
  );
}

class PromptWidget extends StatefulWidget {
  final String? title;
  final dynamic value;
  final String? confirmText;
  final String? cancelText;
  final Function(String?) onSubmit;
  final bool? numberOnly;

  const PromptWidget({
    Key? key,
    this.value,
    required this.title,
    this.confirmText,
    this.cancelText,
    this.numberOnly = false,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<PromptWidget> createState() => _PromptWidgetState();
}

class _PromptWidgetState extends State<PromptWidget> {
  String? inputValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
      title: Row(children: [
        Text(
          widget.title ?? 'Info',
          style: TextStyle(color: AppColors.black, fontSize: 18),
        )
      ]),
      content: MyTextInput(
        icon: Icons.discount,
        placeholder: 'Discount',
        onChanged: _inputChanged,
        value: widget.value,
        numberOnly: widget.numberOnly,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () => {Navigator.pop(context)},
              child: Text(widget.cancelText ?? 'Cancel'),
            ),
            mr(3),
            PrimaryButton(
              value: widget.confirmText ?? 'Confirm',
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
    );
  }

  _inputChanged(String? data, String? column) {
    setState(() {
      inputValue = data;
    });
  }
}
