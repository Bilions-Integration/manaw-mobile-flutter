import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/custom_app_bar_2.dart';
import 'package:my_app/components/custom_item_list.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/screens/tabs/management/account/account_create_and_edit.dart';
import 'package:my_app/screens/tabs/management/account/components/action_popup.dart';
import 'package:my_app/services/account_service.dart';
import 'package:my_app/helpers/helper.dart';

class AccountList extends StatefulWidget {
  const AccountList({Key? key}) : super(key: key);

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  bool isSearch = false;
  bool isLoading = false;
  bool isLastPage = false;
  List accounts = [];
  Map<String,dynamic> params = {
    'page' : 1,
    'limit' : 20,
    "select": true
  };

  @override
  void initState() {
    getAccounts();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar2(
        context: context,
        title: 'Accounts',
        isSearch: isSearch,
        toggleSearch: () {
          setState(() {
            isSearch = !isSearch;
          });
        },
        search: () {},
        add: () => Get.to(const AccountCreateAndEdit()),
      ),
      body: list(context),
    );
  }

  Widget list(BuildContext context) {
    return  CustomItemList(
      refresh: refresh,
      items: accounts, 
      params: params, 
      loadMore: loadMore, 
      isLoading: isLoading, 
      isLastPage: isLastPage,
      emptyWidget: Styles.emptyList('No Account yet', AppAssets.emptyCategory, 'Create new Account', const AccountCreateAndEdit()),
      itemBuilder: (context, index) => Column(
        children: [
          InkWell(
            onLongPress: () => Styles.customBottomSheet(context, 20,
              ActionPopup(
                id: accounts[index].id, 
                edit: (id) => Get.to(AccountCreateAndEdit(id :accounts[index].id)), 
                delete: (id) => deleteData(accounts[index].id)
              )
            ),
            child: listItem(accounts[index]),
          ),
          mb(0.7),
        ],
      )
    );
  }

  Widget listItem(account) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color : const Color(0xffE2E2E2),
        )
      ),
      child: ListTile(
        title: Text(account.bankName, style: Styles.h5,),
        subtitle: Text(account.ownerName, style: Styles.l6,),
        trailing: Text('\$${account.initialAmount}', style: Styles.t5,),
      ),
    );
  }

  getAccounts() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 1000), () async {
      var res = await AccountService.get(params);
      setState(() {
        accounts = res['data'];
        isLastPage = true;
        isLoading = false;
      });
    });
  }

  Future loadMore() async {
    await AccountService.get(params);
  }

  Future refresh() async{
    var res = await AccountService.get(params);
    setState(() {
      accounts = res['data'];
      isLastPage = true;
    });
  }

  deleteData(int? id) {
    confirm(
      onPressed: (result) async {
        if(result) {
          await AccountService.delete(id);
          setState(() {
            accounts.removeWhere((category) => category.id == id);
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
}