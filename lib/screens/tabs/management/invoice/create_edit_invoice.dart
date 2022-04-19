import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';

import 'components/form_cart.dart';

class CreateInvoice extends StatefulWidget {
  const CreateInvoice({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateInvoice> createState() => _CreateInvoiceState();
}

class _CreateInvoiceState extends State<CreateInvoice> {
  final Map<String,dynamic> params = {
    'invoice_date' : '2021-11-07',
    'receiver_name' : null,
    'receiver_email' : null,
    'receiver_phone' : null,
    'tax_id' : null,
    'billing_address' : null,
    'shipping_address' : null,
    'receiver_auto_create' : true,
    'account_id' : null,
    
    'discount_type' : 'fixed',
    'discount' : 0,
    'invoice_number' : null,
    'ref_number' : null,
    'tax' : 5,
    'vat_type' : 'inclusive',
    'paid_amount' : null,
    'products' : [
      {
        'name' : 'product name',
        'product_id' : 2,
        'quantity' : 1,
        'price' : 1000
      }
    ]
  };

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Invoice", 
          style: TextStyle(fontSize : 17)
        ),
        leading:IconButton(
          icon: SvgPicture.asset(AppAssets.leftArrow,width: 23, height: 23, color: AppColors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: loading == false
          ? FormCard(params : params) 
          : Center(child: CircularProgressIndicator(color :  AppColors.dark)
        )
      )
    );
  }
}
