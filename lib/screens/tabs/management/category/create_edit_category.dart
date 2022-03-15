import 'package:flutter/material.dart';

class CreateCategory extends StatelessWidget {
  const CreateCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Category"),
      ),
      body: const Center(
        child: Text("Create Category Screen"),
      ),
    );
  }
}
