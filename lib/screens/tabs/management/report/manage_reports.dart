import 'package:flutter/material.dart';

class ManageReport extends StatelessWidget {
  const ManageReport({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports"),
      ),
      body: const Center(
        child: Text("Reports Screen"),
      ),
    );
  }
}
