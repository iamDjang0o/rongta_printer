import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'rongta_printer_method_channel.dart';

abstract class RongtaPrinterPlatform extends PlatformInterface {
  /// Constructs a RongtaPrinterPlatform.
  RongtaPrinterPlatform() : super(token: _token);

  static final Object _token = Object();

  static RongtaPrinterPlatform _instance = MethodChannelRongtaPrinter();

  /// The default instance of [RongtaPrinterPlatform] to use.
  ///
  /// Defaults to [MethodChannelRongtaPrinter].
  static RongtaPrinterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RongtaPrinterPlatform] when
  /// they register themselves.
  static set instance(RongtaPrinterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> init({
    required String macAddress,
    Function(bool isConnected)? onPrinterConnectionChange,
    Function()? onDocPrinted,
  }) {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<Uint8List> print({
    required Uint8List doc,
  }) {
    throw UnimplementedError('print() has not been implemented.');
  }
}
