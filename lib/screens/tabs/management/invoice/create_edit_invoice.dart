import 'package:flutter/material.dart';

class CreateInvoice extends StatelessWidget {
  const CreateInvoice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Invoice"),
      ),
      body: const Center(
        child: Text("Create Invoice Screen"),
      ),
    );
  }
}
