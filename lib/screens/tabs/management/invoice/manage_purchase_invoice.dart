import 'package:flutter/material.dart';

import 'components/manage_invoice.dart';

class ManagePurchaseInvoice extends StatelessWidget {
  const ManagePurchaseInvoice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ManageInvoice(type: 'purchase');
  }
}
