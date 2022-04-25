import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_app/components/custom_app_bar_2.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/screens/tabs/management/category/manage_category.dart';
import 'package:my_app/services/category_service.dart';

import 'components/form_card.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({
    Key? key,
    this.id,
  }) : super(key: key);

  final int? id;

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  Map<String, dynamic> params = {
    "name": null,
    "image" : null,
    // "enable_selling" : true,
  };

  bool loading = false;

  @override
  void initState() {
    super.initState();
    if(widget.id != null) {
      loading = true;
      Future.delayed(const Duration(milliseconds: 1000), () {
        fetchData();
      });
    }
  }

  Future submit() async {
    if(widget.id == null) {
      await CategoryService.create(params);
      Get.snackbar(
        'Success',
        'Successfully Created',
        icon: const Icon(Icons.check_circle),
      );
    } else {
      await CategoryService.update(widget.id, params);
      Get.snackbar(
        'Success',
        'Successfully Updated',
        icon: const Icon(Icons.check_circle),
      );
    }
    Get.to(const ManageCategory());
  }

  Future fetchData() async {
    var res = await CategoryService.fetch(widget.id);
    Map<String, dynamic> data = res;
    // data['enable_selling'] = true;
    data['old_image'] = data['image'];
    data['image'] = null;
    setState(() {
      params = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: customAppBar2(
        context: context,
        title: 'Category ${widget.id != null ? "Edit" : "Create"}',
        showAction: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: loading == false
          ? FormCard(params : params, editId : widget.id, submit : () => submit() ) 
          : Center(child: CircularProgressIndicator(color :  AppColors.dark))
      )
    );
  }
}
