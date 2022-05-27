import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/printer_setting/printer_card.dart';
import 'package:my_app/screens/printer_setting/printer_setting_controller.dart';
import 'package:pos_printer_manager/models/pos_printer.dart';
import 'package:pos_printer_manager/pos_printer_manager.dart';

class PrinterSettingScreen extends StatefulWidget {
  const PrinterSettingScreen({Key? key}) : super(key: key);

  @override
  _PrinterSettingScreenState createState() => _PrinterSettingScreenState();
}

class _PrinterSettingScreenState extends State<PrinterSettingScreen> {
  final printerSettingController = Get.put(PrinterSettingController());

  var defaultPrinter = '';

  CapabilityProfile? profile;

  BluetoothPrinterManager? manager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: const Text('Printer Setting'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
      ),
      body: Container(
        color: AppColors.white,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Obx(
              () => (Expanded(
                child: ListView(
                  children: [
                    ...printerSettingController.bluetoothPrinters.value
                        .mapIndexed(
                          (BluetoothPrinter data, index) => printerCard(
                            data,
                            defaultPrinter,
                            'BLUETOOTH',
                            _setPrinter,
                          ),
                        )
                        .toList(),
                    ...printerSettingController.usbPrinters.value
                        .mapIndexed(
                          (USBPrinter data, index) => printerCard(
                            data,
                            defaultPrinter,
                            'USB',
                            _setPrinter,
                          ),
                        )
                        .toList()
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    printerSettingController.scanBluePrinter();
    printerSettingController.scanUSBPrinter();
    final box = GetStorage();
    final address = box.read('@printer-address');
    setState(() {
      defaultPrinter = (address != null) ? address : '';
    });
  }

  _setPrinter(POSPrinter printer) {
    confirm(
      onPressed: (confirm) async {
        if (confirm) {
          final box = GetStorage();
          box.write('@printer-address', printer.address);
          box.write('@printer-name', printer.name);
          box.write('@printer-id', printer.id);
          box.write('@printer-connectionType',
              printer.connectionType.toString().split('.').last);
          console.log(box.read('@printer-connectionType'));
          setState(() {
            defaultPrinter = printer.address ?? '';
          });
          Get.snackbar('Success', 'Successfully set to ${printer.name}');
        }
      },
      title: '${printer.name}',
      message:
          'Are you sure you want to set ${printer.name} as default printer?',
    );
  }
}
