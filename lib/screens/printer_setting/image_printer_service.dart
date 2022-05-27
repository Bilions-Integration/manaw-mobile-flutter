import 'dart:typed_data';

import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:image/image.dart' as img;

class ImagePrinterService {
  final Uint8List? receipt;
  List<int>? _bytes;
  PaperSize? _paperSize;
  CapabilityProfile? profile;
  ImagePrinterService(this.receipt, this.profile);

  List<int>? get bytes => _bytes;

  Future<List<int>> getBytes({
    PaperSize paperSize = PaperSize.mm80,
    String name = "default",
  }) async {
    List<int> bytes = [];
    _paperSize = paperSize;
    assert(receipt != null);
    assert(_paperSize != null);
    assert(profile != null);
    Generator generator = Generator(_paperSize!, profile!);
    final img.Image _resize =
        img.copyResize(img.decodeImage(receipt!)!, width: _paperSize!.width);
    bytes += generator.image(_resize);
    bytes += generator.feed(2);
    bytes += generator.cut();
    return bytes;
  }
}
