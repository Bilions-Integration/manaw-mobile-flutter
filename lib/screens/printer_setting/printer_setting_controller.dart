import 'package:get/get.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:pos_printer_manager/pos_printer_manager.dart';

class PrinterSettingController extends GetxController {
  final bluetoothPrinters = Rx<List<BluetoothPrinter>>([]);

  final usbPrinters = Rx<List<USBPrinter>>([]);

  scanBluePrinter() async {
    var printers = await BluetoothPrinterManager.discover();
    console.log(printers.toList().toString());
    bluetoothPrinters.value = printers;
  }

  scanUSBPrinter() async {
    var printers = await USBPrinterManager.discover();
    console.log(printers.toList().toString());
    usbPrinters.value = printers;
  }
}
