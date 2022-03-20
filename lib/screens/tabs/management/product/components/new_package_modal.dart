import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/components/text_tapper.dart';
import 'package:my_app/helpers/helper.dart';

class NewPackageModal {
  NewPackageModal();

  void open(Function(Map) onSubmit) {
    BuildContext context = currentContext();
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      context: context,
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).size.height - 50,
          padding: MediaQuery.of(context).viewInsets,
          child: NewPackageForm(
            onSubmit: onSubmit,
          ),
        );
      },
    );
  }
}

// List View Widget
class NewPackageForm extends StatefulWidget {
  final Function(Map) onSubmit;
  const NewPackageForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<NewPackageForm> createState() => _NewPackageFormState();
}

class _NewPackageFormState extends State<NewPackageForm> {
  Map params = {
    "unit": null,
    "coefficient": 1,
    "sale_price": 0,
    "purchase_price": 0,
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('New Variation'.toUpperCase()),
                          const Spacer(),
                          TextTapper(
                            title: 'CANCEL',
                            onTab: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      mb(2),
                      MyTextInput(
                        value: params['unit'],
                        column: 'unit',
                        label: 'Name',
                        placeholder: 'Red Color',
                        onChanged: _valueChanged,
                      ),
                      MyTextInput(
                        value: params['coefficient'],
                        column: 'coefficient',
                        label: 'Coefficient',
                        numberOnly: true,
                        placeholder: '0',
                        onChanged: _valueChanged,
                      ),
                      MyTextInput(
                        value: params['sale_price'],
                        column: 'sale_price',
                        label: 'Sale Price',
                        placeholder: '0',
                        numberOnly: true,
                        onChanged: _valueChanged,
                      ),
                      MyTextInput(
                        value: params['purchase_price'],
                        column: 'purchase_price',
                        label: 'Purchase Price',
                        placeholder: '0',
                        numberOnly: true,
                        onChanged: _valueChanged,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: PrimaryButton(value: 'Create', onPressed: _submit),
            )
          ],
        ),
      ),
    );
  }

  _valueChanged(val, String? col) {
    setState(() {
      params[col] = val;
    });
  }

  _submit() {
    widget.onSubmit(params);
    setState(() {
      params = {
        "unit": null,
        "coefficient": 1,
        "sale_price": 0,
        "purchase_price": 0,
      };
    });
    Navigator.pop(context);
  }
}
