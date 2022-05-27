import 'package:flutter/material.dart';
import 'package:my_app/components/custom_app_bar_2.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/services/category_service.dart';

import 'components/form_card.dart';

class CreateCategory extends StatefulWidget {
  final int? id;

  const CreateCategory({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  Map<String, dynamic> params = {
    "name": null,
    "image": null,
    // "enable_selling" : true,
  };

  bool loading = false;

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
                ? FormCard(
                    params: params, editId: widget.id, submit: () => submit())
                : Center(
                    child:
                        CircularProgressIndicator(color: AppColors.primary))));
  }

  Future fetchData() async {
    var res = await CategoryService.fetch(widget.id);
    Map<String, dynamic> data = res;
    data['old_image'] = data['image'];
    data['image'] = null;
    setState(() {
      params = data;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      loading = true;
      Future.delayed(const Duration(milliseconds: 1000), () {
        fetchData();
      });
    }
  }

  Future submit() async {
    if (widget.id == null) {
      await CategoryService.create(params);
      snackBar(
        'Success',
        'Successfully Created',
        icon: Icons.check_circle,
      );
    } else {
      await CategoryService.update(widget.id, params);
      snackBar(
        'Success',
        'Successfully Updated',
        icon: Icons.check_circle,
      );
    }
    Navigator.pop(context);
  }
}
