import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/printer_setting/printer_setting.dart';
import 'package:my_app/services/my_printer_service.dart';
import 'package:pos_printer_manager/models/pos_printer.dart';

class PosService {
  downloadReceipt(invoiceId) async {
    try {
      loading(title: 'Saving');
      final service = MyPrinterService();
      await service.downloadReceipt(invoiceId);
      hideLoading();
    } catch (error) {
      hideLoading();
    }
  }

  print(invoiceId) async {
    try {
      if (!Platform.isAndroid) {
        return downloadReceipt(invoiceId);
      }
      final service = MyPrinterService();
      POSPrinter? printer = service.getPrinter();

      if (printer == null) {
        confirm(
          onPressed: (confirm) {
            if (confirm) {
              Get.to(() => const PrinterSettingScreen());
            }
          },
          title: 'Printer not selected yet',
          message: 'Do you want to select printer?',
          confirmText: 'Yes',
        );
      } else {
        loading(title: 'Printing...');
        await service.print(invoiceId, printer);
        hideLoading();
      }
    } catch (error) {
      hideLoading();
      snackBar('Error', 'Something went wrong try again!',
          icon: Icons.error_outline_rounded, color: Colors.red);
      console.log(error);
    }
  }
}
