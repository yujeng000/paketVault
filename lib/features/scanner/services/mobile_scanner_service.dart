import 'dart:async';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:paketvault/features/scanner/services/scanner_service.dart';

class MobileScannerServiceImpl implements ScannerService {
  MobileScannerServiceImpl() {
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  late final MobileScannerController _controller;
  final _barcodeController = StreamController<String?>.broadcast();
  bool _isFlashOn = false;
  bool _disposed = false;

  MobileScannerController get controller => _controller;

  @override
  Stream<String?> get barcodeStream => _barcodeController.stream;

  @override
  bool get isFlashOn => _isFlashOn;

  void onBarcodeDetected(BarcodeCapture capture) {
    if (_disposed) return;
    final rawValue = capture.barcodes.firstOrNull?.rawValue;
    if (rawValue != null && rawValue.isNotEmpty) {
      _barcodeController.add(rawValue);
    }
  }

  @override
  Future<void> toggleFlash() async {
    if (_disposed) return;
    await _controller.toggleTorch();
    _isFlashOn = !_isFlashOn;
  }

  @override
  Future<void> start() async {
    if (_disposed) return;
    await _controller.start();
  }

  @override
  Future<void> stop() async {
    if (_disposed) return;
    await _controller.stop();
  }

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    await _controller.dispose();
    await _barcodeController.close();
  }
}
