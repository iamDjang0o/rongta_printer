import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'rongta_printer_platform_interface.dart';

/// An implementation of [RongtaPrinterPlatform] that uses method channels.
class MethodChannelRongtaPrinter extends RongtaPrinterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('rongta_printer/channel');

  @override
  Future<void> init({
    required String macAddress,
    Function(bool isConnected)? onPrinterConnectionChange,
    Function()? onDocPrinted,
  }) async {
    methodChannel.setMethodCallHandler((call) {
      switch (call.method) {
        case 'on_printer_connected':
          if (onPrinterConnectionChange != null) {
            onPrinterConnectionChange(true);
          }

          break;
        case 'on_printer_disconnected':
          if (onPrinterConnectionChange != null) {
            onPrinterConnectionChange(false);
          }

          break;
        case 'on_printer_write_completion':
          if (onDocPrinted != null) {
            onDocPrinted();
          }

          break;
      }

      return Future.value();
    });

    return await methodChannel.invokeMethod(
      'init',
      {
        'mac_address': macAddress,
      },
    );
  }

  @override
  Future<Function> print({
    required Uint8List doc,
  }) async {
    return await methodChannel.invokeMethod(
      'print',
      {
        'doc': doc,
      },
    );
  }
}
