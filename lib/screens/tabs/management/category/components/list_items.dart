import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/styles.dart';
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
        ? Styles.loading
        : widget.categories.isEmpty
        ? Styles.emptyList('No Category yet', AppAssets.emptyCategory, 'Create new Category', const CreateCategory())
        : ListView.builder(
          controller: widget.scrollController,
          itemCount: widget.categories.length,
          itemBuilder: (context,int index) => listItem(widget.categories[index])
        ),
    );
  }

  Widget listItem(category) {
    return ListTile(
      title: Text(category.name, style: Styles.t5),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(category.image, height: 33, width: 37, fit: BoxFit.cover)
      ),
      trailing: IconButton(
        icon: SvgPicture.asset(AppAssets.dotAction,width: 20, height: 20, color : AppColors.dark),
        onPressed: () => Styles.customBottomSheet(context, 20,
          ActionPopup(
            id: category.id, 
            edit: (id) => Get.to(CreateCategory(id : id)), 
            delete: (id) => widget.delete(id)
          )
        ),
        // onPressed: () => actionPopup(
        //   id : category.id,
        //   category : category, 
        //   context : context, 
        //   edit : (id) => Get.to(CreateCategory(id : id)),
        //   delete : (id) => widget.delete(id)
        // )
      ),
    );
  }
}

