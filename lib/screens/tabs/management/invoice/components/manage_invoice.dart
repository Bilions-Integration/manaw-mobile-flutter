import 'package:flutter/material.dart';
import 'package:my_app/components/custom_app_bar_2.dart';
import 'package:my_app/components/date_picker.dart';
import 'package:my_app/model/invoice_model/invoice_model.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/tabs/management/invoice/components/list_items.dart';
import 'package:my_app/services/invoice_services.dart';
import 'package:my_app/helpers/moment.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:get/get.dart';

class ManageInvoice extends StatefulWidget {
  const ManageInvoice({
    Key? key, 
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  State<ManageInvoice> createState() => _ManageInvoiceState();
}

class _ManageInvoiceState extends State<ManageInvoice> {
  bool isSearch = false;
  bool isLoading = false;
  bool isLastPage = false;
  List<InvoiceModel> invoices = [];

  Map<String,dynamic> params = {
    'page' : 1,
    'limit' : 10,
    'end_date' : moment.string(DateTime.now()),
    'start_date' : moment.string(DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)),
    'keyword' : ''
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar2(
        context: context,
        title: widget.type == 'sale' ? 'Sale Invoices' : 'Purchase Invoices',
        isSearch: isSearch,
        toggleSearch: () {
          setState(() {
            isSearch = !isSearch;
            if(!isSearch) {
              params['keyword'] = '';
              getData();
            }
          });
        },
        search: (value) {
          setState(() {
            params['keyword'] = value;
            getData();
          });
        },
        add: () => Get.to(RouteName.product),
      ),
      body: Column(
        children: [
          DatePicker(
            startDate: params['start_date'],
            endDate: params['end_date'],
            onDateChanged: (startDate, endDate) {
              setState(() {
                params['start_date'] = startDate;
                params['end_date'] = endDate;
              });
              getData();
            },
          ),
          Expanded(
            child : ListItems(
              type : widget.type,
              isLoading : isLoading,
              invoices : invoices,
              delete : (id) => deleteData(id),
              print : (id) => printData(id),
              isLastPage: isLastPage, 
              loadMore: loadMore, 
              refresh: refresh, 
              params: params,
            ),
          )
        ],
      ),
    );
  }

  deleteData(int? id) {
    confirm(
      onPressed: (result) {
        if(result) {
          setState(() {
            invoices.removeWhere((invoice) => invoice.id == id);
            Navigator.pop(context);
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

  printData(int? id) async {
    await InvoiceServices.print(id);
  }

  getData() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 1000), () async {
      var res = await InvoiceServices.get(params);
      setState(() {
        invoices = res['invoices'];
        isLoading = false;
      });
    });
  }

  Future loadMore() async {
    var res = await InvoiceServices.get(params);
    setState(() {
      invoices = [...invoices, ...res['invoices']];
      isLastPage = res['last_page'];
    });
  }

  Future refresh() async{
    var res = await InvoiceServices.get(params);
    setState(() {
      invoices = res['invoices'];
      isLastPage = res['last_page'];
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      params['type'] = widget.type;
    });
    getData();
  }
}

