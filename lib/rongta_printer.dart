import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import 'core/types.dart';
import 'helpers/widget_to_image_converter.dart';
import 'rongta_printer_platform_interface.dart';

class RongtaPrinter {
  Future<void> init({
    required String macAddress,
    OnPrinterConnectionChange? onPrinterConnectionChange,
    OnPrinterOperationChange? onDocPrinted,
  }) async {
    return await RongtaPrinterPlatform.instance.init(
      macAddress: macAddress,
      onPrinterConnectionChange: onPrinterConnectionChange,
      onDocPrinted: onDocPrinted,
    );
  }

  Future<Uint8List> print({
    required Widget doc,
  }) async {
    return await RongtaPrinterPlatform.instance.print(
      doc: await createImageFromWidget(doc),
    );
  }
}
