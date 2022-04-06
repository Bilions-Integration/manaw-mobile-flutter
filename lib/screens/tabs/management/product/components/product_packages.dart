import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_option_model.dart';
import 'package:my_app/screens/tabs/management/product/components/new_package_modal.dart';
import 'package:my_app/screens/tabs/management/product/product_option_controller.dart';

class ProductPackages extends StatefulWidget {
  final Function() afterMutation;
  final int? productId;
  final List<ProductOption>? options;
  const ProductPackages(
      {Key? key, required this.afterMutation, this.productId, this.options})
      : super(key: key);

  @override
  State<ProductPackages> createState() => _ProductPackagesState();
}

class _ProductPackagesState extends State<ProductPackages> {
  List<Map> packages = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        hr(height: 15),
        ...?widget.options
            ?.mapIndexed((e, i) => Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        _edit(e);
                      },
                      child: PackageViewCard(option: e),
                    ),
                    Positioned(
                      right: 10,
                      top: 7,
                      child: InkWell(
                        onTap: () {
                          _remove(e);
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

  _edit(ProductOption unit) {
    NewPackageModal(params: unit.toJson()).open((Map units) {
      widget.afterMutation();
    }, widget.productId);
  }

  _remove(ProductOption unit) async {
    var optionController = ProductOptionController();
    try {
      var res = await optionController.deleteOption(
          id: unit.id!, productId: unit.productId);
      if (res['success']) {
        widget.afterMutation();
      }
    } catch (e) {
      console.warn(e.toString());
    }
  }

  _showAddPackageModal() {
    NewPackageModal().open((Map units) {
      widget.afterMutation();
    }, widget.productId);
  }
}

class PackageViewCard extends StatelessWidget {
  final ProductOption option;
  const PackageViewCard({
    Key? key,
    required this.option,
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
            child: Text(option.name),
          ),
          hr(),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    'Sell Price',
                    style: TextStyle(color: AppColors.grey),
                  ),
                ),
                Text(
                  'Buy Price',
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
                  child: Text('${currency()} ${cast(option.salePrice)}'),
                ),
                Text('${currency()} ${cast(option.purchasePrice)}'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10, top: 5),
            child: Row(
              children: [
                Text('Coefficient : ${option.coefficient}'),
              ],
            ),
          ),
          mb(1.5),
        ],
      ),
    );
  }
}
