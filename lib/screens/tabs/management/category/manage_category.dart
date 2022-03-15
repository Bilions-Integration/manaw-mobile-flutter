import 'package:flutter/material.dart';

class ManageCategory extends StatelessWidget {
  const ManageCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Category"),
      ),
      body: const Center(
        child: Text("Manage Category Screen"),
      ),
    );
  }
}
