abstract class ScannerService {
  Stream<String?> get barcodeStream;
  bool get isFlashOn;
  Future<void> toggleFlash();
  Future<void> start();
  Future<void> stop();
  Future<void> dispose();
}
