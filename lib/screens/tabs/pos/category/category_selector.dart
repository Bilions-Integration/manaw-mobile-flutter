import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/category_picker.dart';
import 'package:my_app/components/common_widget.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/util_models.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/tabs/pos/cart_controller.dart';
import 'package:my_app/services/category_service.dart';

class CategorySelector extends StatefulWidget {
  final Function(CategoryModel) callback;
  const CategorySelector({
    Key? key,
    required this.callback,
  }) : super(key: key);
  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  List<CategoryModel> menuList = [];

  CategoryModel? selectedList;

  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Material(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primary,
            border: Border(
              top: BorderSide(color: AppColors.white, width: 0.2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _showList,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Text(
                          selectedList?.name ?? 'selectCategory'.tr,
                          style: TextStyle(color: AppColors.white),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          AppAssets.icSearch,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Material(
                      color: Colors.transparent,
                      child: (InkWell(
                        onTap: _showCheckout,
                        child: Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(10),
                          child: cartController.total() > 0
                              ? Badge(
                                  badgeContent: Text(
                                    cartController.total().toString(),
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                  child:
                                      const IconTapper(icon: AppAssets.icCart),
                                )
                              : const IconTapper(icon: AppAssets.icCart),
                        ),
                      )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _afterMutation(ProductMutationResult? result) {
    if (result != null) {
      widget.callback(CategoryModel(
        name: 'all'.tr,
        id: null,
        image: [],
      ));
    }
  }

  _getCategory() async {
    if (menuList.isEmpty) {
      List<CategoryModel> initialCategories = [
        CategoryModel(
          name: 'All',
          id: null,
          image: [],
        )
      ];
      var res = await CategoryService.get({'page': 1, 'limit': 10});
      List<CategoryModel> categories = res['categories'];
      setState(() {
        menuList = [...initialCategories, ...categories];
      });
    }
  }

  _onSelect(CategoryModel data) {
    setState(() {
      selectedList = data;
    });
    widget.callback(data);
  }

  _showCheckout() {
    Get.to(() => RouteName.checkoutScreen)
        ?.then((res) => _afterMutation(res as ProductMutationResult));
  }

  _showList() async {
    await _getCategory();
    CategoryPicker(
      onSelect: _onSelect,
      menuList: menuList,
    ).open();
  }
}
