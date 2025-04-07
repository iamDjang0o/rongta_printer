import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rongta_printer/core/enums.dart';
import 'package:rongta_printer/rongta_printer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey printKey = GlobalKey();

  PrinterConnectionStatus connectionStatus = PrinterConnectionStatus.initial;
  PrinterOperationStatus operationStatus = PrinterOperationStatus.idle;

  final _rongtaPrinterPlugin = RongtaPrinter();

  @override
  void initState() {
    super.initState();
    initRongtaPlugin();
  }

  void onConnectionStatusChanged(PrinterConnectionStatus status) {
    log(connectionStatus.name, name: 'onConnectionStatusChanged');

    setState(() {
      connectionStatus = status;
    });
  }

  void onOperationStatusChanged(PrinterOperationStatus status) {
    log(operationStatus.name, name: 'onOperationStatusChanged');

    setState(() {
      operationStatus = status;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initRongtaPlugin() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        connectionStatus = PrinterConnectionStatus.loading;

        log(connectionStatus.name, name: 'initRongtaPlugin');

        setState(() {});
      });

      // Request Bluetooth permissions
      await _requestBluetoothPermissions();

      await _rongtaPrinterPlugin.init(
        macAddress: 'DC:0D:30:E0:1B:9B',
        onPrinterConnectionChange: onConnectionStatusChanged,
        onDocPrinted: onOperationStatusChanged,
      );
    } on PlatformException {
      log(
        'Unable to initialize the rongta printer plugin',
        name: 'initRongtaPlugin',
      );
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  Future<void> _requestBluetoothPermissions() async {
    // For Android 12+ (API level 31+)
    if (await Permission.bluetoothConnect.status.isDenied) {
      await Permission.bluetoothConnect.request();
    }

    if (await Permission.bluetoothScan.status.isDenied) {
      await Permission.bluetoothScan.request();
    }
  }

  Widget? connectionStatusWidget() {
    switch (connectionStatus) {
      case PrinterConnectionStatus.initial:
        return null;
      case PrinterConnectionStatus.loading:
        return const CircularProgressIndicator();
      case PrinterConnectionStatus.connected:
        return const Icon(
          Icons.check_circle,
          color: Colors.green,
        );
      case PrinterConnectionStatus.disconnected:
        return const Icon(
          Icons.error,
          color: Colors.red,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Rongta printer example'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Connection status: ${connectionStatus.name}'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      connectionStatus == PrinterConnectionStatus.connected
                          ? () {
                              _rongtaPrinterPlugin.print(
                                context, // This context should now have an Overlay
                                doc: const Text('Simple print test'),
                              );
                            }
                          : null,
                  child: const Text('Print a test doc'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
