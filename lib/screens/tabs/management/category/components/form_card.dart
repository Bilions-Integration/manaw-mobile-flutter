import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/helpers/helper.dart';

import 'image_uploader.dart';

class FormCard extends StatefulWidget {
  final Map<String, dynamic> params;

  final int? editId;
  final Future<dynamic> Function() submit;
  const FormCard(
      {Key? key, required this.params, this.editId, required this.submit})
      : super(key: key);

  @override
  State<FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageUploader(params: widget.params),
            mb(2),
            const Text('Category Name', style: TextStyle(fontSize: 15)),
            mb(1),
            MyTextInput(
              value: widget.params['name'],
              onChanged: _onValueChanged,
              column: 'name',
              placeholder: 'Enter Category Name',
            ),
          ],
        ),
        PrimaryButton(
            value: widget.editId == null ? 'Create' : 'Update',
            onPressed: () => widget.submit())
      ],
    );
  }

  _onValueChanged(value, column) {
    setState(() {
      widget.params[column] = value;
    });
  }
}
