import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/unit_model.dart';
import 'package:my_app/screens/tabs/management/product/components/new_package_modal.dart';
import 'package:my_app/screens/tabs/management/product/product_option_controller.dart';

class ProductPackages extends StatefulWidget {
  final Function() afterMutation;
  final int? productId;
  final List<Unit>? units;
  const ProductPackages(
      {Key? key, required this.afterMutation, this.productId, this.units})
      : super(key: key);

  @override
  State<ProductPackages> createState() => _ProductPackagesState();
}

class _ProductPackagesState extends State<ProductPackages> {
  List<Map> packages = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hr(height: 15),
        SizedBox(
          height: 24,
          child: Text(
            'VARIATIONS',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.grey,
            ),
          ),
        ),
        ...?widget.units
            ?.mapIndexed((unit, i) => Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        _edit(unit);
                      },
                      child: PackageViewCard(unit: unit),
                    ),
                    Positioned(
                      right: 10,
                      top: 7,
                      child: InkWell(
                        onTap: () {
                          _remove(unit);
                        },
                        child: Icon(
                          Icons.remove_circle,
                          color: AppColors.red,
                        ),
                      ),
                    )
                  ],
                ))
            .toList(),
        mb(1),
        SecondaryButton(
          height: 40,
          value: '+ Add new variation',
          onPressed: _showAddPackageModal,
        )
      ],
    );
  }

  _edit(Unit unit) {
    NewPackageModal(params: unit.toJson())
        .open(widget.afterMutation, widget.productId);
  }

  _remove(Unit unit) async {
    var optionController = ProductOptionController();
    try {
      bool success = await optionController.deleteOption(
          id: unit.id!, productId: unit.productId);
      if (success) {
        widget.afterMutation();
      }
    } catch (e) {
      console.warn(e.toString());
    }
  }

  _showAddPackageModal() {
    NewPackageModal().open(widget.afterMutation, widget.productId);
  }
}

class PackageViewCard extends StatelessWidget {
  final Unit unit;
  const PackageViewCard({
    Key? key,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Text(
              unit.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          hr(),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    'Sale Price',
                    style: TextStyle(color: AppColors.grey),
                  ),
                ),
                Text(
                  'Purchase Price',
                  style: TextStyle(color: AppColors.grey),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10, top: 2),
            child: Row(
              children: [
                SizedBox(
                  width: 150,
                  child: Text('${currency()} ${cast(unit.salePrice)}'),
                ),
                Text('${currency()} ${cast(unit.purchasePrice)}'),
              ],
            ),
          ),
          mb(1),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 10,
            ),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: unit.active ? AppColors.primary : AppColors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                unit.active ? 'Active' : 'Inactive',
                style: TextStyle(
                    fontSize: 12,
                    color: unit.active ? AppColors.primary : AppColors.grey),
              ),
            ),
          ),
          mb(1.5),
        ],
      ),
    );
  }
}
