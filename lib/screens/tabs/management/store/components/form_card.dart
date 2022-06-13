import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/common_model.dart';
import 'package:my_app/screens/tabs/management/store/components/image_card.dart';

class FormCard extends StatefulWidget {
  final Map<String, dynamic> params;

  final Function() submit;
  const FormCard({
    Key? key,
    required this.params,
    required this.submit,
  }) : super(key: key);

  @override
  State<FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: ListView(
              shrinkWrap: true,
              children: [
                mb(1.5),
                ImageCard(
                  logo: widget.params['old_logo'],
                  banner: widget.params['old_banner'],
                  callback: (MyFile image, String type) {
                    setState(() {
                      if (type == 'logo') {
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
                    label: 'storeName'.tr),
                MyTextInput(
                  value: widget.params['currencySymbol'],
                  onChanged: _onValueChanged,
                  column: 'currencySymbol',
                  placeholder: '',
                  label: 'currency'.tr,
                ),
                MyTextInput(
                  value: widget.params['tax_id'],
                  onChanged: _onValueChanged,
                  column: 'tax_id',
                  placeholder: '',
                  label: 'taxId'.tr,
                  numberOnly: true,
                ),
                MyTextInput(
                  value: widget.params['tax'],
                  onChanged: _onValueChanged,
                  column: 'tax',
                  placeholder: '',
                  label: 'defaultTax'.tr,
                  numberOnly: true,
                ),
                MyTextInput(
                  value: widget.params['wht'],
                  onChanged: _onValueChanged,
                  column: 'wht',
                  placeholder: '',
                  label: 'defaultWht'.tr,
                  numberOnly: true,
                ),
                MyTextInput(
                  value: widget.params['purchase_inv_prefix'],
                  onChanged: _onValueChanged,
                  column: 'purchase_inv_prefix',
                  placeholder: '',
                  label: 'purchaseInvoicePrefix'.tr,
                ),
                MyTextInput(
                  value: widget.params['sale_inv_prefix'],
                  onChanged: _onValueChanged,
                  column: 'sale_inv_prefix',
                  placeholder: '',
                  label: 'saleInvoicePrefix'.tr,
                ),
                MyTextInput(
                  value: widget.params['phone'],
                  onChanged: _onValueChanged,
                  column: 'phone',
                  placeholder: '',
                  numberOnly: true,
                  label: 'phone'.tr,
                ),
                MyTextInput(
                  value: widget.params['email'],
                  onChanged: _onValueChanged,
                  column: 'email',
                  placeholder: '',
                  label: 'email'.tr,
                ),
                MyTextInput(
                  value: widget.params['address'],
                  onChanged: _onValueChanged,
                  column: 'address',
                  placeholder: 'Address . . .',
                  label: 'address'.tr,
                  textarea: true,
                ),
              ],
            ),
          ),
        ),
        Container(
          color: AppColors.bg,
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 15),
          child: PrimaryButton(value: 'Save', onPressed: widget.submit),
        ),
      ],
    );
  }

  _onValueChanged(value, column) {
    setState(() {
      widget.params[column] = value;
    });
  }
}
