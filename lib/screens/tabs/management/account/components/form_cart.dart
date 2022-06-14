import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/helpers/helper.dart';

class FormCard extends StatefulWidget {
  const FormCard({
    Key? key,
    required this.params,
    required this.submit,
  }) : super(key: key);

  final Map<String, dynamic> params;
  final Function() submit;

  @override
  State<FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MyTextInput(
              value: widget.params['bank_name'],
              onChanged: _onValueChanged,
              column: 'bank_name',
              placeholder: 'bankName'.tr,
              label: 'bankName'.tr),
          MyTextInput(
            value: widget.params['owner_name'],
            onChanged: _onValueChanged,
            column: 'owner_name',
            placeholder: 'ownerName'.tr,
            label: 'ownerName'.tr,
          ),
          MyTextInput(
            value: widget.params['initial_amount'],
            onChanged: _onValueChanged,
            column: 'initial_amount',
            placeholder: 'initialBalance'.tr,
            label: 'initialBalance'.tr,
            numberOnly: true,
          ),
          mb(2),
          PrimaryButton(value: 'save'.tr, onPressed: widget.submit),
          mb(1),
        ],
      ),
    );
  }

  _onValueChanged(value, column) {
    setState(() {
      widget.params[column] = value;
    });
  }
}
