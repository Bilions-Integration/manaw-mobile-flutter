import 'package:flutter/material.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';

class VariationSelect {
  void open() {
    BuildContext context = currentContext();
    showModalBottomSheet(
        context: context,
        shape: Styles.topOnlyBorderRadius(15),
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Text('Hello Worldj'),
          );
        });
  }
}
