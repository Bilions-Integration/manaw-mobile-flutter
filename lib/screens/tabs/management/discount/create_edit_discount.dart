import 'package:flutter/material.dart';

class CreateDiscount extends StatelessWidget {
  const CreateDiscount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Discount"),
      ),
      body: const Center(
        child: Text("Create Discount Screen"),
      ),
    );
  }
}
