import 'package:flutter/material.dart';

showMyModal({required BuildContext context, required WidgetBuilder builder}) {
  showDialog(
    context: context, 
    builder: (BuildContext context) {
      return ShowMyModal(builder: builder);
    }
  );
}

class ShowMyModal extends StatelessWidget {
  const ShowMyModal({
    Key? key,
    required this.builder
  }) : super(key: key);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      insetPadding: const EdgeInsets.all(10),
      child: Builder(
        builder: builder
      ),
    );
  }
}