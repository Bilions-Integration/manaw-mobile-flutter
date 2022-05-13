// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';

showColorPicker({
  String? title,
  dynamic value,
  String? confirmText,
  String? cancelText,
  bool? numberOnly,
  required Function(String) onColorChange,
}) {
  final context = currentContext();
  showDialog(
    context: context,
    useSafeArea: false,
    barrierDismissible: false,
    builder: (context) => MyColorPicker(onColorChange: onColorChange),
  );
}

class MyColorPicker extends StatelessWidget {
  final Function(String) onColorChange;

  var myColor = '';

  MyColorPicker({Key? key, required this.onColorChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primary,
          title: const Text('Color Picker'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => {Navigator.pop(context)},
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: MaterialColorPicker(
                  onColorChange: _onColorChange,
                  selectedColor: Colors.red,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: PrimaryButton(
                value: 'Pick Color',
                onPressed: () {
                  Navigator.pop(context);
                  if (myColor.isNotEmpty) {
                    onColorChange(myColor);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _onColorChange(Color color) {
    var hex = color.value.toRadixString(16);
    hex = '#${hex.substring(2, hex.length)}';
    myColor = hex;
  }
}
