
import 'package:flutter/material.dart';
import 'package:my_app/data/assets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/screens/tabs/management/category/create_edit_category.dart';
import 'package:my_app/services/category_service.dart';
import 'components/list_items.dart';

class ManageCategory extends StatefulWidget {
  const ManageCategory({
    Key? key,
  }) : super(key: key);

  @override
  State<ManageCategory> createState() => _ManageCategoryState();
}

class _ManageCategoryState extends State<ManageCategory> {
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  bool isLastPage = false;
  List<CategoryModel> categories = [];
  Map<String,dynamic> params = {
    'page' : 1,
    'limit' : 11,
    'keyword' : ''
  };

  void scrollListener() {
    if(scrollController.offset >= scrollController.position.maxScrollExtent && !isLastPage) {
      isLoading = true;
      setState(() {
        params['page'] += 1;
      });
      getData();
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  getData() async {
    var res = await CategoryService.get(params);
    setState(() {
      categories = params['page'] == 1
        ? res['categories']
        : [...categories, ...res['categories']];
      isLastPage = categories.length == res['total'] ? true : false;
      isLoading = false;
    });
  }

  Future deleteData(int? id) async {
    await CategoryService.delete(id);
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    Future.delayed(const Duration(milliseconds: 1000), () {
      getData();
    });
    scrollController.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleAndSearch(),
        backgroundColor: AppColors.dark,
        titleSpacing: 0,
        leading:IconButton(
          icon: SvgPicture.asset(AppAssets.leftArrow,width: 23, height: 23, color: AppColors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
        openAndCloseSearch(),
          IconButton(
            icon: SvgPicture.asset(AppAssets.plus,width: 17, height: 17, color: AppColors.white),
            onPressed: () => Get.to(const CreateCategory()),
          ),
        ],
      ),
      body: 
      ListItems(
        isLoading : isLoading,
        categories : categories,
        delete : (id) => deleteData(id),
        getData: () => getData(),
        scrollController: scrollController,
      ),
    );
  }

  bool isSearch = false;

  Widget titleAndSearch() {
    return isSearch
    ? TextFormField(
      style : TextStyle(
        color : AppColors.white, 
        fontSize : 17
      ),
      onFieldSubmitted : (value) => search(value),
      decoration: const InputDecoration(
        border: InputBorder.none
      ),
      cursorColor : AppColors.white,
      autofocus : true,
    )
    :Text("Manage Category", style: TextStyle(
      fontSize: 17,
      color: AppColors.white
    ));
  }

  Widget openAndCloseSearch() {
    return isSearch
    ? IconButton(
      icon: const Icon(Icons.clear, size: 20),
      onPressed: () {
        setState(() {
          isSearch = false;
          params['keyword'] = '';
          params['page'] = 1;
        });
        getData();
      },
    )
    : IconButton(
      icon: SvgPicture.asset(AppAssets.search,width: 20, height: 20, color: AppColors.white),
      onPressed: () {
        setState(() {
          isSearch = true;
          params['keyword'] = '';
          params['page'] = 1;
        });
        getData();
      },
    );
  }

  search(value) {
    setState(() {
      params['keyword'] = value;
      params['page'] = 1;
    });
    getData();
  }

}


