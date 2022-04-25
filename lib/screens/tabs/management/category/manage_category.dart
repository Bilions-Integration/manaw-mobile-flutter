
import 'package:flutter/material.dart';
import 'package:my_app/components/custom_app_bar_2.dart';
import 'package:my_app/components/custom_item_list.dart';
import 'package:my_app/data/assets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/screens/tabs/management/category/components/action_popup.dart';
import 'package:my_app/screens/tabs/management/category/create_edit_category.dart';
import 'package:my_app/services/category_service.dart';
import 'package:my_app/helpers/helper.dart';

class ManageCategory extends StatefulWidget {
  const ManageCategory({
    Key? key,
  }) : super(key: key);

  @override
  State<ManageCategory> createState() => _ManageCategoryState();
}

class _ManageCategoryState extends State<ManageCategory> {
  bool isLoading = false;
  bool isLastPage = false;
  bool isSearch = false;
  List<CategoryModel> categories = [];
  Map<String,dynamic> params = {
    'page' : 1,
    'limit' : 20,
    'keyword' : ''
  };

  getData() async {
    var res = await CategoryService.get(params);
    setState(() {
      categories = res['categories'];
      isLastPage = categories.length >= res['total'] ? true : false;
      isLoading = false;
    });
  }

  Future deleteData(int? id) async {
    confirm(
      onPressed: (result) async {
        if(result) {
          await CategoryService.delete(id);
          setState(() {
            categories.removeWhere((category) => category.id == id);
          });
          Get.snackbar(
            'Success',
            'Successfully Deleted',
            icon: const Icon(Icons.check_circle),
          );
        }
      },
      title: 'Delete',
      message: "Are you sure, you want to delete?",
      confirmText: 'Yes',
    );
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    Future.delayed(const Duration(milliseconds: 1000), () {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar2(
        context: context, 
        title: 'Manage Category',
        isSearch: isSearch,
        toggleSearch: () {
          setState(() {
            isSearch = !isSearch;
            if(!isSearch) {
              params['keyword'] = '';
              getData();
            }
          });
        },
        search: (value) {
          setState(() {
            params['page'] = 1;
            params['keyword'] = value;
            getData();
          });
        },
        add: () => Get.to(const CreateCategory()),
      ),
      body: CustomItemList(
        refresh: refresh,
        items: categories, 
        params: params, 
        loadMore: loadMore, 
        isLoading: isLoading, 
        isLastPage: isLastPage, 
        emptyWidget: Styles.emptyList('No Coupon yet', AppAssets.emptyCategory, 'Create new Coupon', const CreateCategory()),
        itemBuilder: (context, index) => listItem(categories[index]),
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
            delete: (id) => deleteData(id)
          )
        ),
      ),
    );
  }

  Future loadMore() async {
    var res = await CategoryService.get(params);
    setState(() {
      categories = [...categories, ...res['categories']];
      isLastPage = categories.length >= res['total'] ? true : false;
    });
  }

  Future refresh() async {
    var res = await CategoryService.get(params);
    setState(() {
      categories = res['categories'];
      isLastPage = (categories.length >= res['total']) ? true : false;
    });
  }






}


