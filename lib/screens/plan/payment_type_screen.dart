import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';

class PaymentType extends StatefulWidget {
  const PaymentType({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PaymentTypeState();
  }
}

class _PaymentTypeState extends State<PaymentType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Text('Payment Method'),
      ),
    );
  }
}
