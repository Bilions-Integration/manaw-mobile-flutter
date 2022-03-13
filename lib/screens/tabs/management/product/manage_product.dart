import 'package:flutter/material.dart';

class ManageProduct extends StatelessWidget {
  const ManageProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Product"),
      ),
      body: Center(
        child: Text("Manage Product Screen"),
      ),
    );
  }
}
