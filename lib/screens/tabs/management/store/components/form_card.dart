import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/common_model.dart';
import 'package:my_app/screens/tabs/management/store/components/image_card.dart';

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
           ImageCard(
            logo: widget.params['old_logo'],
            banner: widget.params['old_banner'],
            callback: (MyFile image, String type) {
              setState(() {
                if(type == 'logo') {
                  widget.params['logo'] = image.blob;
                } else {
                  widget.params['banner'] = image.blob;
                }
              });               
            },
          ),
          MyTextInput(
            value: widget.params['name'],
            onChanged: _onValueChanged,
            column: 'name',
            placeholder: '',
            label: 'Store Name'),
          MyTextInput(
            value: widget.params['currencySymbol'],
            onChanged: _onValueChanged,
            column: 'currencySymbol',
            placeholder: '',
            label: 'Currency',
          ),
          MyTextInput(
            value: widget.params['tax_id'],
            onChanged: _onValueChanged,
            column: 'tax_id',
            placeholder: '',
            label: 'Tax ID',
            numberOnly: true,
          ),
          MyTextInput(
            value: widget.params['tax'],
            onChanged: _onValueChanged,
            column: 'tax',
            placeholder: '',
            label: 'Default Tax (%)',
            numberOnly: true,
          ),
          MyTextInput(
            value: widget.params['wht'],
            onChanged: _onValueChanged,
            column: 'wht',
            placeholder: '',
            label: 'Default WHT (%)',
            numberOnly: true,
          ),
          MyTextInput(
            value: widget.params['purchase_inv_prefix'],
            onChanged: _onValueChanged,
            column: 'purchase_inv_prefix',
            placeholder: '',
            label: 'Purchase Invoice Prefix',
          ),
          MyTextInput(
            value: widget.params['sale_inv_prefix'],
            onChanged: _onValueChanged,
            column: 'sale_inv_prefix',
            placeholder: '',
            label: 'Sale Invoice Prefix',
          ),
          MyTextInput(
            value: widget.params['phone'],
            onChanged: _onValueChanged,
            column: 'phone',
            placeholder: '',
            numberOnly: true,
            label: 'Phone',
          ),
          MyTextInput(
            value: widget.params['email'],
            onChanged: _onValueChanged,
            column: 'email',
            placeholder: '',
            label: 'Email',
          ),
          MyTextInput(
            value: widget.params['address'],
            onChanged: _onValueChanged,
            column: 'address',
            placeholder: 'Address . . .',
            label: 'Address',
            textarea: true,
          ),
          mb(2),
          PrimaryButton(value: 'Save', onPressed: widget.submit),
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
