import 'package:flutter/material.dart';

class ManageStore extends StatelessWidget {
  const ManageStore({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Store"),
      ),
      body: const Center(
        child: Text("Manage Store Screen"),
      ),
    );
  }
}
