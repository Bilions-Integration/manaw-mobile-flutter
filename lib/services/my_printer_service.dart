import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:my_app/helpers/helper.dart';
import 'package:my_app/screens/printer_setting/image_printer_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pos_printer_manager/models/pos_printer.dart';
import 'package:pos_printer_manager/pos_printer_manager.dart';
import 'package:webcontent_converter/webcontent_converter.dart';

class MyPrinterService {
  CapabilityProfile? profile;

  BluetoothPrinterManager? blueManager;
  USBPrinterManager? usbManager;

  downloadReceipt(id) async {
    requestPermission();
    var ts = DateTime.now().millisecondsSinceEpoch;
    var savedPath = "pos-download-$ts";
    Uint8List image = await WebcontentConverter.webUriToImage(uri: getUri(id));
    await ImageGallerySaver.saveImage(
      Uint8List.fromList(image),
      name: savedPath,
    );
    Get.snackbar('Success', 'Saved to gallery');
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

  Future getProfile() async {
    if (profile == null) {
      var p = await CapabilityProfile.load();
      profile = p;
    }
    return profile;
  }

  getUri(id) {
    int ios = Platform.isIOS ? 1 : 0;
    final box = GetStorage();
    final token = 'Bearer ' + box.read('@bearerToken');
    final baseUrl = dotenv.env['APP_URL'].toString();
    final url =
        '$baseUrl/invoice/$id/print_pos_mb?authorization=$token&ios=$ios';
    console.log(url);
    return url;
  }

  print(id, printer) async {
    try {
      console.log('printing');

      var image = await WebcontentConverter.webUriToImage(uri: getUri(id));

      var paperSize = PaperSize.mm58;
      CapabilityProfile loadedProfile = await getProfile();

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
            BluetoothPrinterManager(printer, paperSize, loadedProfile);
        blueManager = m;
        await blueManager?.connect();
        console.log("isConnected ${blueManager?.isConnected}");
        blueManager?.writeBytes(data, isDisconnect: false);
      } else if (printer.connectionType == ConnectionType.usb) {
        USBPrinterManager m =
            USBPrinterManager(printer, paperSize, loadedProfile);
        usbManager = m;
        await usbManager?.connect();
        console.log("isConnected ${usbManager?.isConnected}");
        usbManager?.writeBytes(data, isDisconnect: false);
      }
    } catch (error) {
      console.log(error);
    }
  }

  requestPermission() async {
    await [
      Permission.storage,
    ].request();
  }
}
