import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/printer_setting/image_printer_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pos_printer_manager/models/pos_printer.dart';
import 'package:pos_printer_manager/pos_printer_manager.dart';
import 'package:webcontent_converter/webcontent_converter.dart';

class MyPrinterService {
  CapabilityProfile? profile;

  BluetoothPrinterManager? blueManager;
  USBPrinterManager? usbManager;

  downloadReceipt(id) async {
    String? dir = await getDownloadPath();
    var ts = DateTime.now().millisecondsSinceEpoch;
    var savedPath = dir! + "/pos-download-$ts.jpg";
    Uint8List image = await WebcontentConverter.webUriToImage(uri: getUri(id));
    File(savedPath).writeAsBytes(image);
    Get.snackbar('Success', 'Saved to gallery');
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      return null;
    }
    return directory?.path;
  }

  POSPrinter? getPrinter() {
    final box = GetStorage();
    final address = box.read('@printer-address');
    final name = box.read('@printer-name');
    final id = box.read('@printer-id');
    final connType = box.read('@printer-connectionType');

    if (address.toString().isEmpty) {
      return null;
    }

    return POSPrinter(
      id: id,
      address: address,
      name: name,
      connectionType: connType == 'bluetooth'
          ? ConnectionType.bluetooth
          : ConnectionType.usb,
    );
  }

  Future<CapabilityProfile?> getProfile() async {
    if (profile == null) {
      var p = await CapabilityProfile.load();
      profile = p;
    }
    return profile;
  }

  getUri(id) {
    final box = GetStorage();
    final token = 'Bearer ' + box.read('@bearerToken');
    final baseUrl = dotenv.env['APP_URL'].toString();
    final url = '$baseUrl/invoice/$id/print_pos_mb?authorization=$token';
    console.log(url);
    return url;
  }

  print(id, printer) async {
    console.log('printing');

    var image = await WebcontentConverter.webUriToImage(uri: getUri(id));

    var paperSize = PaperSize.mm58;
    CapabilityProfile? loadedProfile = await getProfile();

    var service = ImagePrinterService(image, loadedProfile);
    var data = await service.getBytes(paperSize: PaperSize.mm58);

    console.log(data);

    if (blueManager != null) {
      blueManager?.disconnect();
    }
    if (usbManager != null) {
      usbManager?.disconnect();
    }
    blueManager = null;
    usbManager = null;

    if (printer.connectionType == ConnectionType.bluetooth) {
      BluetoothPrinterManager m =
          BluetoothPrinterManager(printer, paperSize, loadedProfile!);
      blueManager = m;
      await blueManager?.connect();
      console.log("isConnected ${blueManager?.isConnected}");
      blueManager?.writeBytes(data);
    } else if (printer.connectionType == ConnectionType.usb) {
      USBPrinterManager m =
          USBPrinterManager(printer, paperSize, loadedProfile!);
      usbManager = m;
      await usbManager?.connect();
      console.log("isConnected ${usbManager?.isConnected}");
      usbManager?.writeBytes(data);
    }
  }
}
