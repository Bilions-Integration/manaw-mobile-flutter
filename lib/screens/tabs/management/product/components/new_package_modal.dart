import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/components/input.dart';
import 'package:my_app/components/text_tapper.dart';
import 'package:my_app/helpers/helper.dart';

class NewPackageModal {
  NewPackageModal();

  void open() {
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
          child: const NewPackageForm(),
        );
      },
    );
  }
}

// List View Widget
class NewPackageForm extends StatefulWidget {
  const NewPackageForm({Key? key}) : super(key: key);

  @override
  State<NewPackageForm> createState() => _NewPackageFormState();
}

class _NewPackageFormState extends State<NewPackageForm> {
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
                        label: 'Name',
                        placeholder: 'Red Color',
                        onChanged: (val, String? col) {},
                      ),
                      MyTextInput(
                        value: '1',
                        label: 'Coefficient',
                        numberOnly: true,
                        placeholder: '0',
                        onChanged: (val, String? col) {},
                      ),
                      MyTextInput(
                        label: 'Sale Price',
                        placeholder: '0',
                        numberOnly: true,
                        onChanged: (val, String? col) {},
                      ),
                      MyTextInput(
                        label: 'Purchase Price',
                        placeholder: '0',
                        numberOnly: true,
                        onChanged: (val, String? col) {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: PrimaryButton(value: 'Create', onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}
