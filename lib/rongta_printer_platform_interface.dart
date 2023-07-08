import 'dart:typed_data';

import 'core/types.dart';
import 'rongta_printer_method_channel.dart';

abstract class RongtaPrinterPlatform {
  /// Constructs a RongtaPrinterPlatform.
  RongtaPrinterPlatform();

  static RongtaPrinterPlatform instance = MethodChannelRongtaPrinter();

  Future<void> init({
    required String macAddress,
    OnPrinterConnectionChange? onPrinterConnectionChange,
    OnPrinterOperationChange? onDocPrinted,
  }) {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<Uint8List> print({
    required Uint8List doc,
  }) {
    throw UnimplementedError('print() has not been implemented.');
  }
}
