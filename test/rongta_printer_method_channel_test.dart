import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rongta_printer/rongta_printer_method_channel.dart';

void main() {
  MethodChannelRongtaPrinter platform = MethodChannelRongtaPrinter();
  const MethodChannel channel = MethodChannel('rongta_printer');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
