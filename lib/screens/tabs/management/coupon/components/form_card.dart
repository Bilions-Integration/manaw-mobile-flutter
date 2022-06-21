import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';

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
  List<String> customerEmails = [''];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          mb(1),
          Text(
            'specificCustomers'.tr,
            style: Styles.label,
          ),
          mb(0.2),
          Text(
            "leaveBlankForAll".tr,
            style: Styles.l6,
          ),
          mb(0.5),
          ...(widget.params['customer_emails'] as List<String>).mapIndexed(
            (e, index) => MyTextInput(
                placeholder: 'customerEmail'.tr,
                column: index.toString(),
                value: e,
                onChanged: _onCustomerEmailChange),
          ),
          Center(
              child: TextButton(
                  onPressed: _addEmailInput,
                  child: Text('addAnotherCustomer'.tr))),
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

  _onCustomerEmailChange(value, column) {
    setState(() {
      customerEmails[int.parse(column)] = value;
      widget.params['customer_emails'][int.parse(column)] = value;
    });
  }

  _addEmailInput() {
    setState(() {
      customerEmails.add('');
      widget.params['customer_emails'].add('');
    });
  }

  getInputParamByType() =>
      widget.params['type'] == 'fixed' ? 'amount' : 'percent';
}
