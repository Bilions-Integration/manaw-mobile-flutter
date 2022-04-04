import 'package:flutter/material.dart';

class ManagePurchaseInvoice extends StatelessWidget {
  const ManagePurchaseInvoice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Invoice"),
      ),
      body: const Center(
        child: Text("Manage Invoice Screen"),
      ),
    );
  }
}
