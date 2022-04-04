import 'package:flutter/material.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/colors.dart';

import 'image_uploader.dart';

class FormCard extends StatefulWidget {
  const FormCard({
    Key? key, 
    required this.params, 
    this.editId, 
    required this.submit
  }) : super(key: key);

  final Map<String,dynamic> params;
  final int? editId;
  final Future<dynamic> Function() submit;

  @override
  State<FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  _onValueChanged(value, column) {
    setState(() {
      widget.params[column] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageUploader(params : widget.params),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Category Name', style: TextStyle(fontSize: 15)),
            const SizedBox(height: 7),
            MyTextInput(
              value : widget.params['name'],
              onChanged: _onValueChanged,
              column: 'name',
              placeholder: 'Enter Category Name',
            ),
            Row(
              mainAxisAlignment : MainAxisAlignment.spaceBetween,
              children: [
                const Text('Enable Selling', style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),),
                Switch.adaptive(
                  activeColor: AppColors.dark,
                  value: widget.params['enable_selling'],
                  onChanged: (value) =>_onValueChanged(value, 'enable_selling')
                )
              ]
            ),
            const SizedBox(height: 7),
            PrimaryButton(
              value: widget.editId == null ? 'Create' : 'Update',
              onPressed: () => widget.submit()
            )
          ],
        )
      ],
    );
  }
}