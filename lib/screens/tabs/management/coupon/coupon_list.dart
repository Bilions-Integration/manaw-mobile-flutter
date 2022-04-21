import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/custom_app_bar_2.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/screens/tabs/management/category/components/action_popup.dart';
import 'package:my_app/screens/tabs/management/coupon/coupon_create_and_edit.dart';
import 'package:my_app/components/custom_item_list.dart';
import 'package:my_app/services/coupon_service.dart';
import 'package:my_app/helpers/helper.dart';

class CouponList extends StatefulWidget {
  const CouponList({Key? key}) : super(key: key);

  @override
  State<CouponList> createState() => _CouponListState();
}

class _CouponListState extends State<CouponList> {
  bool isSearch = false;
  bool isLoading = false;
  bool isLastPage = false;
  List coupons = [];
  Map<String, dynamic> params = {
    'page' : 1,
    'limit' : 10
  };
  
  @override
  void initState() {
    getCoupons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar2(
        context: context,
        title: 'Coupons',
        isSearch: isSearch,
        toggleSearch: () {
          setState(() {
            isSearch = !isSearch;
          });
        },
        search: () {},
        add: () => Get.to(const CouponCreateAndEdit()),
      ),
      body: list(context));
  }

  Widget list(BuildContext context) {
    return  CustomItemList(
      items: coupons, 
      params: params, 
      loadMore: loadMore, 
      isLoading: isLoading, 
      isLastPage: isLastPage, 
      emptyWidget: Styles.emptyList('No Coupon yet', AppAssets.emptyCategory, 'Create new Coupon', const CouponCreateAndEdit()),
      itemBuilder: (context, index) => Column(
        children: [
          InkWell(
            onLongPress: () => Styles.customBottomSheet(context, 20,
              ActionPopup(
                id: coupons[index].id, 
                edit: (id) => Get.to(CouponCreateAndEdit(id : coupons[index].id)), 
                delete: (id) => deleteData(coupons[index].id)
              )
            ),
            child: ListTile(
              title: Text(coupons[index].name),
              subtitle: Text(coupons[index].couponCode),
            )
          ),
        ],
      )
    );
  }

  Future deleteData(int? id) async {
    confirm(
      onPressed: (result) async {
        if(result) {
          Map<String, List> deleteParams = {
            'discount_ids' : [ id ],
          };
          await CouponService.delete(deleteParams);
          setState(() {
            coupons.removeWhere((category) => category.id == id);
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

  getCoupons() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 1000), () async {
      var res = await CouponService.get(params);
      setState(() {
        isLoading = false;
        coupons = params['page'] == 1 ? res['data'] : [...coupons, ...res['data']];
        isLastPage = res['last_page'];
      });
    });
  }

  Future loadMore() async {
    var res = await CouponService.get(params);
    setState(() {
      coupons = [...coupons, ...res['data']];
      isLastPage = res['last_page'];
    });
  }

}
