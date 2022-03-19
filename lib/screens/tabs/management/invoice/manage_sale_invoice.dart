import 'package:flutter/material.dart';

class ManageSaleInvoice extends StatelessWidget {
  const ManageSaleInvoice({
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
