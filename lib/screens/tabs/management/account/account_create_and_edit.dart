import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/custom_app_bar_2.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/screens/tabs/management/account/account_list.dart';
import 'package:my_app/screens/tabs/management/account/components/form_cart.dart';
import 'package:my_app/services/account_service.dart';

class AccountCreateAndEdit extends StatefulWidget {
  const AccountCreateAndEdit({Key? key, this.id}) : super(key: key);

  final int? id;

  @override
  State<AccountCreateAndEdit> createState() => _AccountCreateAndEditState();
}

class _AccountCreateAndEditState extends State<AccountCreateAndEdit> {
  bool loading = false;
  Map<String, dynamic> params = {
    'owner_name': null,
    'account_number': '-',
    'bank_name': null,
    'initial_amount': null,
    'current_amount': null,
  };

  @override
  void initState() {
    if (widget.id != null) {
      fetchData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar2(
          context: context,
          title: 'Coupon ${widget.id != null ? "Edit" : "Create"}',
          showAction: false,
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: loading == false
                ? FormCard(
                    params: params,
                    submit: submit,
                  )
                : Styles.loading));
  }

  submit() async {
    if (widget.id != null) {
      await AccountService.update(widget.id, params);
      Get.snackbar(
        'Success',
        'Successfully Updated',
        icon: const Icon(Icons.check_circle),
      );
    } else {
      await AccountService.create(params);
      Get.snackbar(
        'Success',
        'Successfully Created',
        icon: const Icon(Icons.check_circle),
      );
    }
    Get.to(const AccountList());
  }

  fetchData() {
    setState(() {
      loading = true;
    });
    Future.delayed(const Duration(milliseconds: 1000), () async {
      var res = await AccountService.fetch(widget.id);
      setState(() {
        params['owner_name'] = res['owner_name'];
        params['account_number'] = res['account_number'];
        params['bank_name'] = res['bank_name'];
        params['initial_amount'] = res['initial_amount'];
        params['current_amount'] = res['current_amount'];
        loading = false;
      });
    });
  }
}
