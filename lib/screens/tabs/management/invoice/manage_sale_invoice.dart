import 'package:flutter/material.dart';

import 'components/manage_invoice.dart';

class ManageSaleInvoice extends StatelessWidget {
  const ManageSaleInvoice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ManageInvoice(type : 'sale');
  }
}
