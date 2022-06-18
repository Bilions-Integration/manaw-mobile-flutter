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
              value: widget.params['name'],
              onChanged: _onValueChanged,
              column: 'name',
              placeholder: 'couponName'.tr,
              label: 'couponName'.tr),
          MyTextInput(
            value: widget.params['coupon_code'],
            onChanged: _onValueChanged,
            column: 'coupon_code',
            placeholder: 'couponCodePlaceholder'.tr,
            label: 'couponCode'.tr,
          ),
          Row(
            children: [
              Radio(
                value: 'fixed',
                groupValue: widget.params['type'],
                onChanged: (value) => _onValueChanged(value, 'type'),
              ),
              Text('fixed'.tr),
              Radio(
                value: 'percentage',
                groupValue: widget.params['type'],
                onChanged: (value) => _onValueChanged(value, 'type'),
              ),
              Text('percentage'.tr),
            ],
          ),
          MyTextInput(
            value: widget.params[getInputParamByType()],
            onChanged: _onValueChanged,
            column: getInputParamByType(),
            placeholder:
                '${widget.params['type'] == 'fixed' ? 'Amount' : 'Percent'} off',
            numberOnly: true,
          ),
          MyTextInput(
            value: widget.params['useable_time'],
            onChanged: _onValueChanged,
            column: 'useable_time',
            placeholder: 'usableTimePlaceholder'.tr,
            label: 'usableTime'.tr,
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

  getInputParamByType() =>
      widget.params['type'] == 'fixed' ? 'amount' : 'percent';
}
