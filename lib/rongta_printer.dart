import 'package:flutter/widgets.dart';

import 'helpers/widget_to_image_converter.dart';
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
    required Widget doc,
  }) async {
    return await RongtaPrinterPlatform.instance.print(
      doc: await createImageFromWidget(doc),
    );
  }
}
