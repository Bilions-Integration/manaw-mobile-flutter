import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/tabs/management/product/components/new_package_modal.dart';

class ProductPackages extends StatefulWidget {
  const ProductPackages({Key? key}) : super(key: key);

  @override
  State<ProductPackages> createState() => _ProductPackagesState();
}

class _ProductPackagesState extends State<ProductPackages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        hr(height: 15),
        SecondaryButton(
          height: 40,
          value: '+ Add new variation',
          onPressed: _showAddPackageModal,
        )
      ],
    );
  }

  _showAddPackageModal() {
    NewPackageModal().open();
  }
}
