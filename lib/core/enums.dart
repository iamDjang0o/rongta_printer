enum PrinterConnectionStatus {
  initial,
  loading,
  connected,
  disconnected,
}

enum PrinterOperationStatus {
  transmitting,
  idle,
}

extension StringX on String {
  PrinterConnectionStatus toPrinterStatus() {
    switch (this) {
      case 'initial':
        return PrinterConnectionStatus.initial;
      case 'loading':
        return PrinterConnectionStatus.loading;
      case 'connected':
        return PrinterConnectionStatus.connected;
      case 'disconnected':
        return PrinterConnectionStatus.disconnected;
      default:
        return PrinterConnectionStatus.initial;
    }
  }

  PrinterOperationStatus toPrinterProcessStatus() {
    switch (this) {
      case 'transmitting':
        return PrinterOperationStatus.transmitting;
      case 'idle':
        return PrinterOperationStatus.idle;
      default:
        return PrinterOperationStatus.idle;
    }
  }
}

extension PrinterStatusX on PrinterConnectionStatus {
  bool get isInitial => this == PrinterConnectionStatus.initial;

  bool get isLoading => this == PrinterConnectionStatus.loading;

  bool get isConnected => this == PrinterConnectionStatus.connected;

  bool get isDisconnected => this == PrinterConnectionStatus.disconnected;
}

extension PrinterProcessStatusX on PrinterOperationStatus {
  bool get isIdle => this == PrinterOperationStatus.idle;

  bool get isTransmitting => this == PrinterOperationStatus.transmitting;
}
