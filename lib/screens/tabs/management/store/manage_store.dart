import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/custom_app_bar_2.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/services/company_service.dart';

import 'components/form_card.dart';

class ManageStore extends StatefulWidget {
  const ManageStore({
    Key? key,
  }) : super(key: key);

  @override
  State<ManageStore> createState() => _ManageStoreState();
}

class _ManageStoreState extends State<ManageStore> {
  Map<String, dynamic> params = {};
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar2(
        context: context,
        title: 'My Store',
        showAction: false,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: loading == false
            ? FormCard(
                params: params,
                submit: submit,
              )
            : Styles.loading,
      ),
    );
  }

  Future fetchData() async {
    setState(() {
      loading = true;
    });

    var res = await CompanyService.fetch();
    var data = res;
    data['old_logo'] = data['logo'];
    data['old_banner'] = data['banner'];
    data['logo'] = null;
    data['banner'] = null;
    setState(() {
      params = data;
      loading = false;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future submit() async {
    await CompanyService.update(params);
    Get.snackbar(
      'Success',
      'Successfully Updated',
      icon: const Icon(Icons.check_circle),
    );
  }
}
