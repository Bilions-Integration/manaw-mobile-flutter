import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/button.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/screens/tabs/management/category/components/action_popup.dart';
import 'package:my_app/screens/tabs/management/category/create_edit_category.dart';

class ListItems extends StatefulWidget {
  const ListItems({
    Key? key, 
    required this.categories, 
    required this.delete, 
    required this.getData, 
    required this.scrollController,
    required this.isLoading, 
  }) : super(key: key);

  final List<CategoryModel> categories;
  final Future<dynamic> Function(int? id) delete;
  final Future<dynamic> Function() getData;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: widget.isLoading
        ? loading()
        : widget.categories.isEmpty
        ? empty()
        : ListView.builder(
          controller: widget.scrollController,
          itemCount: widget.categories.length,
          itemBuilder: (context,int index) => listItem(widget.categories[index])
        ),
    );
  }

  Widget listItem(category) {
    return ListTile(
      title: Text(category.name, style: const TextStyle(
        fontSize: 14,
      )),
      leading: Image.network(category.image, height: 33, width: 39, fit: BoxFit.cover),
      trailing: IconButton(
        icon: SvgPicture.asset(AppAssets.dotAction,width: 20, height: 20, color : AppColors.dark),
        onPressed: () => actionPopup(
          id : category.id,
          category : category, 
          context : context, 
          edit : (id) => Get.to(CreateCategory(id : id)),
          delete : (id) => widget.delete(id)
        )
      ),
    );
  }

  Widget empty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.emptyCategory),
          const Text('No Category Yet'),
          const SizedBox(height: 15),
          SecondaryButton(
            value: 'Add New Category',
            width: 200,
            onPressed: () => Get.to(const CreateCategory()),
          )
        ],
      ),
    );
  }

  Widget loading() {
    return Center(
      child: RefreshProgressIndicator(
        color : AppColors.dark,
      )
    );
  }
}

