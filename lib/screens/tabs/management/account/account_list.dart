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
    'limit' : 10,
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
            child: ListTile(
              title: Text(accounts[index].bankName),
              subtitle: Text(accounts[index].ownerName),
              trailing: Text('\$${accounts[index].initialAmount}'),
            )
          ),
        ],
      )
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
    var res = await AccountService.get(params);
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