import 'package:flutter/material.dart';
import 'package:my_app/model/invoice_model.dart';
import 'package:my_app/screens/tabs/management/invoice/components/list_items.dart';
import 'package:my_app/screens/tabs/management/invoice/components/top_app_bar.dart';
import 'package:my_app/services/invoice_services.dart';
import 'package:my_app/helpers/helper.dart';

class ManageSaleInvoice extends StatefulWidget {
  const ManageSaleInvoice({
    Key? key,
  }) : super(key: key);

  @override
  State<ManageSaleInvoice> createState() => _ManageSaleInvoiceState();
}

class _ManageSaleInvoiceState extends State<ManageSaleInvoice> {
  final ScrollController scrollController = ScrollController();
  bool isSearch = false;
  bool isLoading = false;
  List<InvoiceModel> invoices = [];
  Map<String,dynamic> params = {
    'page' : 1,
    'limit' : 10,
    'type' : 'purchase',
    'start_data' : '2020-02-01',
    'end_date' : '2022-12-04',
    'keyword' : ''
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(
        context : context,
        title : 'Sale Invoices',
        isSearch: isSearch,
        toggleSearch : () {
          setState(() {
            isSearch = !isSearch;
            if(!isSearch) {
              params['keyword'] = '';
              getData();
            }
          });
        },
        search : (value) {
          setState(() {
            params['keyword'] = value;
            getData();
          });
        }
      ),
      body: ListItems(
        isLoading : isLoading,
        invoices : invoices,
        delete : (id) => deleteData(id),
        getData: () => getData(),
        scrollController: scrollController,
      ),
    );
  }

  deleteData(int? id) {
    setState(() {
      invoices.removeWhere((invoice) => invoice.id == id);
      Navigator.pop(context);
    });
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

  @override
  void initState() {
    super.initState();
    getData();
  }
}

