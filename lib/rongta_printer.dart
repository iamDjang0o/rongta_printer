import 'dart:typed_data';

import 'rongta_printer_platform_interface.dart';

class RongtaPrinter {
  Future<void> init({
    required String macAddress,
    Function(bool isConnected)? onPrinterConnectionChange,
    Function()? onDocPrinted,
  }) async {
    return await RongtaPrinterPlatform.instance.init(
      macAddress: macAddress,
      onPrinterConnectionChange: onPrinterConnectionChange,
      onDocPrinted: onDocPrinted,
    );
  }

  Future<void> print({
    required Uint8List doc,
  }) async {
    return await RongtaPrinterPlatform.instance.print(
      doc: doc,
    );
  }
}
