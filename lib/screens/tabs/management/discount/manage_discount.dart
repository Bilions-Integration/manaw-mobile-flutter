import 'package:flutter/material.dart';

class ManageDiscount extends StatelessWidget {
  const ManageDiscount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Discount"),
      ),
      body: const Center(
        child: Text("Manage Discount Screen"),
      ),
    );
  }
}
