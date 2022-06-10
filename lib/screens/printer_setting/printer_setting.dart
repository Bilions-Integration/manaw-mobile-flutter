import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/helpers/styles.dart';
import 'package:my_app/screens/printer_setting/printer_card.dart';
import 'package:my_app/screens/printer_setting/printer_setting_controller.dart';
import 'package:permission_handler/permission_handler.dart';
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
        title: Text('printerSetting'.tr),
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
                child: printerSettingController
                            .bluetoothPrinters.value.isEmpty &&
                        printerSettingController.usbPrinters.value.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(AppAssets.emptyPrinter),
                            mb(1),
                            Text(
                              'emptyPrinter'.tr,
                              style: Styles.l5,
                            ),
                          ],
                        ),
                      )
                    : ListView(
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
    _scan();
  }

  _scan() async {
    await [Permission.bluetoothConnect, Permission.bluetooth].request();
    await printerSettingController.scanBluePrinter();
    await printerSettingController.scanUSBPrinter();
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
          snackBar(
              'success'.tr,
              'printerSetSuccess'
                  .trParams({'printer': printer.name.toString()}));
        }
      },
      title: '${printer.name}',
      message:
          'printerSetConfirm'.trParams({'printer': printer.name.toString()}),
    );
  }
}
