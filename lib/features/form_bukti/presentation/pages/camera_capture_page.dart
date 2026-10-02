import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:paketvault/core/errors/app_exception.dart' hide CameraException;
import 'package:paketvault/core/theme/app_colors.dart';
import 'package:paketvault/core/utils/file_utils.dart';

class CameraCapturePage extends StatefulWidget {
  const CameraCapturePage({super.key, required this.title, required this.resi, required this.suffix});
  final String title;
  final String resi;
  final String suffix;

  @override
  State<CameraCapturePage> createState() => _CameraCapturePageState();
}

class _CameraCapturePageState extends State<CameraCapturePage> {
  CameraController? _controller;
  bool _isInitialized = false;
  bool _isCapturing = false;
  bool _isFlashOn = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        if (mounted) setState(() => _errorMessage = 'Tidak ada kamera tersedia.');
        return;
      }
      final back = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      _controller = CameraController(back, ResolutionPreset.high, enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);
      await _controller!.initialize();
      await _controller!.setFlashMode(FlashMode.off);
      if (mounted) setState(() => _isInitialized = true);
    } on CameraException catch (e) {
      if (mounted) setState(() => _errorMessage = 'Gagal membuka kamera: ${e.description}');
    } catch (e) {
      if (mounted) setState(() => _errorMessage = 'Error: $e');
    }
  }

  Future<void> _toggleFlash() async {
    if (_controller == null || !_isInitialized) return;
    try {
      final next = !_isFlashOn;
      await _controller!.setFlashMode(next ? FlashMode.torch : FlashMode.off);
      if (mounted) setState(() => _isFlashOn = next);
    } catch (_) {}
  }

  Future<void> _capturePhoto() async {
    if (_controller == null || !_isInitialized || _isCapturing) return;
    if (mounted) setState(() => _isCapturing = true);
    try {
      final xFile = await _controller!.takePicture();
      final savedPath = await FileUtils.savePhoto(sourcePath: xFile.path, resi: widget.resi, suffix: widget.suffix);
      if (!mounted) return;
      Navigator.of(context).pop(savedPath);
    } on PhotoException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    } on CameraException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal: ${e.description}')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            if (_isInitialized && _controller != null)
              Positioned.fill(child: CameraPreview(_controller!))
            else if (_errorMessage != null)
              Center(child: Padding(padding: const EdgeInsets.all(24),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.no_photography_outlined, color: Colors.white54, size: 64),
                  const SizedBox(height: 16),
                  Text(_errorMessage!, style: const TextStyle(color: Colors.white70), textAlign: TextAlign.center),
                ])))
            else
              const Center(child: CircularProgressIndicator(color: Colors.white)),

            // AppBar
            Positioned(top: 0, left: 0, right: 0,
              child: Row(children: [
                IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.of(context).pop()),
                Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ])),

            // Senter | Capture
            Positioned(bottom: 0, left: 0, right: 0,
              child: Container(
                decoration: BoxDecoration(gradient: LinearGradient(
                  begin: Alignment.bottomCenter, end: Alignment.topCenter,
                  colors: [Colors.black.withValues(alpha: 0.85), Colors.transparent],
                )),
                padding: const EdgeInsets.fromLTRB(40, 24, 40, 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _CircleButton(
                      size: 56,
                      color: _isFlashOn ? Colors.amber.withValues(alpha: 0.9) : Colors.white24,
                      onTap: _toggleFlash,
                      child: Icon(_isFlashOn ? Icons.flashlight_on : Icons.flashlight_off_outlined,
                          color: _isFlashOn ? Colors.black : Colors.white, size: 26),
                    ),
                    const SizedBox(width: 40),
                    _CircleButton(
                      size: 72,
                      color: _isCapturing ? Colors.grey : Colors.white,
                      borderColor: AppColors.primary,
                      borderWidth: 3,
                      onTap: _isCapturing ? null : _capturePhoto,
                      child: _isCapturing
                          ? const Padding(padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary))
                          : const Icon(Icons.camera_alt, color: Colors.black87, size: 32),
                    ),
                    const SizedBox(width: 96),
                  ],
                ),
              )),
          ],
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.size, required this.color, required this.child, this.onTap, this.borderColor, this.borderWidth = 0});
  final double size;
  final Color color;
  final Widget child;
  final VoidCallback? onTap;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size, height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle, color: color,
          border: borderColor != null ? Border.all(color: borderColor!, width: borderWidth) : null,
        ),
        child: child,
      ),
    );
  }
}
