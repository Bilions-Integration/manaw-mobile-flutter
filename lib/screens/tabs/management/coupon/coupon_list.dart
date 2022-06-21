import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/custom_app_bar_2.dart';
import 'package:my_app/components/custom_item_list.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/screens/tabs/management/category/components/action_popup.dart';
import 'package:my_app/screens/tabs/management/coupon/coupon_create_and_edit.dart';
import 'package:my_app/services/coupon_service.dart';

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
  Map<String, dynamic> params = {'page': 1, 'limit': 20};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bg,
        appBar: customAppBar2(
          context: context,
          title: 'coupons'.tr,
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

  Future deleteData(int? id) async {
    confirm(
      onPressed: (result) async {
        if (result) {
          Map<String, List> deleteParams = {
            'discount_ids': [id],
          };
          await CouponService.delete(deleteParams);
          setState(() {
            coupons.removeWhere((category) => category.id == id);
          });
          snackBar(
            'success'.tr,
            'successDelete'.tr,
            icon: Icons.check_circle,
          );
        }
      },
      title: 'delete'.tr,
      message: "confirmDelete".tr,
      confirmText: 'yes'.tr,
    );
  }

  getCoupons() async {
    setState(() {
      isLoading = true;
    });
    var res = await CouponService.get(params);
    setState(() {
      isLoading = false;
      coupons = res['data'];
      isLastPage = res['last_page'];
    });
  }

  @override
  void initState() {
    getCoupons();
    super.initState();
  }

  Widget list(BuildContext context) {
    return CustomItemList(
      refresh: refresh,
      items: coupons,
      params: params,
      loadMore: loadMore,
      isLoading: isLoading,
      isLastPage: isLastPage,
      emptyWidget: Styles.emptyList(
          label: 'emptyCoupons'.tr,
          image: AppAssets.emptyCategory,
          buttonLabel: 'createCoupon'.tr,
          link: const CouponCreateAndEdit()),
      itemBuilder: (context, index) => Column(
        children: [
          InkWell(
            onTap: () => Styles.customBottomSheet(
              context,
              26,
              ActionPopup(
                id: coupons[index].id,
                edit: (id) => Get.to(
                  CouponCreateAndEdit(id: coupons[index].id),
                ),
                delete: (id) => deleteData(coupons[index].id),
              ),
            ),
            child: borderRadiusCard(
              10,
              ListTile(
                title: Text(coupons[index].name),
                subtitle: Text(
                  coupons[index].couponCode,
                ),
                trailing: coupons[index].type == 'percent'
                    ? Text('${coupons[index].percent} %')
                    : Text('${cast(coupons[index].amount)} ${currency()}'),
              ),
            ),
          ),
          mb(1),
        ],
      ),
    );
  }

  Future loadMore() async {
    var res = await CouponService.get(params);
    setState(() {
      coupons = [...coupons, ...res['data']];
      isLastPage = res['last_page'];
    });
  }

  Future refresh() async {
    var res = await CouponService.get(params);
    setState(() {
      coupons = res['data'];
      isLastPage = res['last_page'];
    });
  }
}
