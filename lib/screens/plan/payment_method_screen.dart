import 'package:flutter/material.dart';
import 'package:my_app/data/colors.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PaymentMethodScreenState();
  }
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
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
