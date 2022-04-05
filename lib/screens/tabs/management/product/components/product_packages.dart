import 'package:flutter/material.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/model/product_option_model.dart';
import 'package:my_app/screens/tabs/management/product/components/new_package_modal.dart';

class ProductPackages extends StatefulWidget {
  final Function(List<Map>) onChanged;
  final int? productId;
  final List<ProductOption>? options;
  const ProductPackages(
      {Key? key, required this.onChanged, this.productId, this.options})
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
                        _edit(i);
                      },
                      child: PackageViewCard(option: e),
                    ),
                    Positioned(
                      right: 10,
                      top: 7,
                      child: InkWell(
                        onTap: () {
                          _remove(i);
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

  _edit(i) {
    List<Map> clonePackages = packages;
    Map package = packages[i];
    NewPackageModal(
      params: package,
    ).open((Map package) {
      clonePackages[i] = package;
      setState(() {
        packages = clonePackages;
      });
      widget.onChanged(packages);
    }, widget.productId);
  }

  _remove(i) {
    List<Map> p = packages;
    p.removeAt(i);
    setState(() {
      packages = p;
    });
    widget.onChanged(packages);
  }

  _showAddPackageModal() {
    NewPackageModal().open((Map package) {
      widget.onChanged(packages);
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
