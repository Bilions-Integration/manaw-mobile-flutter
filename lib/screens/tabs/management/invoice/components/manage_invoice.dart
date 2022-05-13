import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/custom_app_bar_2.dart';
import 'package:my_app/components/date_picker.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/moment.dart';
import 'package:my_app/model/invoice_model/invoice_model.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/screens/tabs/management/invoice/components/list_items.dart';
import 'package:my_app/services/invoice_services.dart';

class ManageInvoice extends StatefulWidget {
  final String type;

  const ManageInvoice({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<ManageInvoice> createState() => _ManageInvoiceState();
}

class _ManageInvoiceState extends State<ManageInvoice> {
  bool isSearch = false;
  bool isLoading = false;
  bool isLastPage = false;
  List<InvoiceModel> invoices = [];

  Map<String, dynamic> params = {
    'page': 1,
    'limit': 10,
    'end_date': moment.string(DateTime.now()),
    'start_date': moment.string(DateTime(
        DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)),
    'keyword': ''
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: customAppBar2(
        context: context,
        title: widget.type == 'sale' ? 'Sale Invoices' : 'Purchase Invoices',
        isSearch: isSearch,
        toggleSearch: _toggleSearch,
        search: _onSearch,
        add: () => Get.to(RouteName.product),
      ),
      body: Column(
        children: [
          DatePicker(
            startDate: params['start_date'],
            endDate: params['end_date'],
            onDateChanged: _onDateChange,
          ),
          Expanded(
            child: ListItems(
              type: widget.type,
              isLoading: isLoading,
              invoices: invoices,
              delete: (id) => _deleteData(id),
              print: (id) => _printData(id),
              isLastPage: isLastPage,
              loadMore: _loadMore,
              refresh: _refresh,
              params: params,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      params['type'] = widget.type;
    });
    _getData();
  }

  _deleteData(int? id) {
    confirm(
      onPressed: (result) {
        if (result) {
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

  _getData() async {
    setState(() {
      isLoading = true;
    });
    var res = await InvoiceServices.get(params);
    setState(() {
      invoices = res['invoices'];
      isLoading = false;
    });
  }

  _loadMore() async {
    var res = await InvoiceServices.get(params);
    setState(() {
      invoices = [...invoices, ...res['invoices']];
      isLastPage = res['last_page'];
    });
  }

  _onDateChange(startDate, endDate) {
    setState(() {
      params['start_date'] = startDate;
      params['end_date'] = endDate;
    });
    _getData();
  }

  _onSearch(value) {
    setState(() {
      params['keyword'] = value;
      _getData();
    });
  }

  _printData(int? id) async {
    await InvoiceServices.print(id);
  }

  _refresh() async {
    var res = await InvoiceServices.get(params);
    setState(() {
      invoices = res['invoices'];
      isLastPage = res['last_page'];
    });
  }

  _toggleSearch() {
    setState(() {
      isSearch = !isSearch;
      if (!isSearch) {
        params['keyword'] = '';
        _getData();
      }
    });
  }
}
