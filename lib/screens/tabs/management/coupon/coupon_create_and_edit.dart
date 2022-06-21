import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/custom_app_bar_2.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/screens/tabs/management/coupon/components/form_card.dart';
import 'package:my_app/screens/tabs/management/coupon/coupon_list.dart';
import 'package:my_app/services/coupon_service.dart';

class CouponCreateAndEdit extends StatefulWidget {
  const CouponCreateAndEdit({
    Key? key,
    this.id,
  }) : super(key: key);

  final int? id;

  @override
  State<CouponCreateAndEdit> createState() => _CouponCreateAndEditState();
}

class _CouponCreateAndEditState extends State<CouponCreateAndEdit> {
  bool loading = false;
  Map<String, dynamic> params = {
    'name': null,
    'coupon_code': null,
    'type': 'fixed',
    'amount': null,
    'percent': null,
    'useable_time': null,
    'valid_from': null,
    'valid_to': null,
    // 'products': [],
    'customer_emails': [''],
    'status': true,
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
          title: widget.id != null ? "editCoupon".tr : "createCoupon".tr,
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
    setState(() {
      (params['customer_emails'] as List<String>)
          .removeWhere((element) => element == '');
    });
    console.log('customer emails : ', payload: params['customer_emails[]']);
    if (widget.id != null) {
      await CouponService.update(widget.id, params);
      snackBar(
        'success'.tr,
        'successUpdate'.tr,
        icon: Icons.check_circle,
      );
    } else {
      await CouponService.create(params);
      snackBar(
        'success'.tr,
        'successCreate'.tr,
        icon: Icons.check_circle,
      );
    }
    Get.to(const CouponList());
  }

  fetchData() {
    setState(() {
      loading = true;
    });
    Future.delayed(const Duration(milliseconds: 1000), () async {
      var res = await CouponService.fetch(widget.id);
      setState(() {
        params['name'] = res['name'];
        params['coupon_code'] = res['coupon_code'];
        params['type'] = res['type'];
        params['amount'] = res['amount'];
        params['percent'] = res['percent'];
        params['useable_time'] = res['useable_time'];
        params['valid_from'] = res['valid_from'];
        params['valid_to'] = res['valid_to'];
        params['valid_to'] = res['valid_to'];
        params['status'] = res['status'];
        params['customer_emails'] =
            (res['customer_emails'] as List).map((e) => e.toString()).toList();
        loading = false;
      });
    });
  }
}
