import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/data/assets.dart';
import 'package:my_app/data/colors.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/printer_setting/printer_setting_controller.dart';
import 'package:pos_printer_manager/pos_printer_manager.dart';

class PrinterSettingScreen extends StatefulWidget {
  const PrinterSettingScreen({Key? key}) : super(key: key);

  @override
  _PrinterSettingScreenState createState() => _PrinterSettingScreenState();
}

class _PrinterSettingScreenState extends State<PrinterSettingScreen> {
  final printerSettingController = Get.put(PrinterSettingController());

  var defaultPrinter = '';

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      printerSettingController.scanBluePrinter();
      printerSettingController.scanUSBPrinter();
      final box = GetStorage();
      final address = box.read('@printer');
      setState(() {
        defaultPrinter = address;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        title: const Text('Printer Setting'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Get.back()},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SizedBox(
            height: double.infinity,
            child: Column(
              children: [
                Obx(
                  () => (Expanded(
                    child: ListView(
                      children: [
                        ...printerSettingController.bluetoothPrinters.value
                            .mapIndexed(
                              (BluetoothPrinter data, index) => printer(
                                data,
                                defaultPrinter,
                                'BLUETOOTH',
                                _setPrinter,
                              ),
                            )
                            .toList(),
                        ...printerSettingController.usbPrinters.value
                            .mapIndexed(
                              (USBPrinter data, index) => printer(
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
        ),
      ),
    );
  }

  _setPrinter(printer) {
    confirm(
      onPressed: (confirm) {
        if (confirm) {
          final box = GetStorage();
          console.log(printer.address);
          box.write('@printer', printer.address);
          setState(() {
            defaultPrinter = printer.address;
          });
        }
      },
      title: '${printer.name}',
      message:
          'Are you sure you want to set ${printer.name} as default printer?',
    );
  }
}

Widget printer(printer, defaultPrinter, type, setPrinter) {
  return Card(
    elevation: 0,
    color: AppColors.lightGrey,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: AppColors.borderColor, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.only(bottom: 6),
    child: InkWell(
      onTap: () {
        setPrinter(printer);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(children: [
          SvgPicture.asset(
            AppAssets.icPrinter,
            width: 40,
          ),
          mr(1),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(printer.name ?? ''),
              Text(
                type,
                style: TextStyle(color: AppColors.lightDark),
              ),
            ],
          )),
          Icon(
            Icons.radio_button_checked,
            size: 20,
            color: defaultPrinter != printer.address
                ? AppColors.lightDark
                : AppColors.blue,
          )
        ]),
      ),
    ),
  );
}
