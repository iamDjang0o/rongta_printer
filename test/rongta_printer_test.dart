import 'package:flutter_test/flutter_test.dart';
import 'package:rongta_printer/rongta_printer.dart';
import 'package:rongta_printer/rongta_printer_platform_interface.dart';
import 'package:rongta_printer/rongta_printer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRongtaPrinterPlatform
    with MockPlatformInterfaceMixin
    implements RongtaPrinterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final RongtaPrinterPlatform initialPlatform = RongtaPrinterPlatform.instance;

  test('$MethodChannelRongtaPrinter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRongtaPrinter>());
  });

  test('getPlatformVersion', () async {
    RongtaPrinter rongtaPrinterPlugin = RongtaPrinter();
    MockRongtaPrinterPlatform fakePlatform = MockRongtaPrinterPlatform();
    RongtaPrinterPlatform.instance = fakePlatform;

    expect(await rongtaPrinterPlugin.getPlatformVersion(), '42');
  });
}
