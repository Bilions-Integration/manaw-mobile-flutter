import 'package:flutter/material.dart';

class ManageInvoice extends StatelessWidget {
  const ManageInvoice({
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
