import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:paketvault/core/routing/app_routes.dart';
import 'package:paketvault/core/theme/app_colors.dart';
import 'package:paketvault/features/scanner/presentation/widgets/scanner_overlay_widget.dart';
import 'package:paketvault/features/scanner/services/mobile_scanner_service.dart';
import 'package:paketvault/features/sync/providers/sync_providers.dart';
import 'package:paketvault/features/delivery/providers/delivery_providers.dart';

class ScannerPage extends ConsumerStatefulWidget {
  const ScannerPage({super.key});

  @override
  ConsumerState<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends ConsumerState<ScannerPage>
    with WidgetsBindingObserver {
  late final MobileScannerServiceImpl _scannerService;
  bool _isFlashOn = false;
  bool _isProcessing = false;
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scannerService = MobileScannerServiceImpl();
    _listenToScan();
    _tryAutoSync();
  }

  void _listenToScan() {
    _scannerService.barcodeStream.listen((rawValue) {
      if (rawValue != null && !_isProcessing) _onBarcodeDetected(rawValue);
    });
  }

  /// Auto-sync saat pertama kali buka scanner, jika ada internet
  Future<void> _tryAutoSync() async {
    final isConfigured = ref.read(isSupabaseConfiguredProvider);
    if (!isConfigured) return;
    try {
      final connected = await ref.read(connectivityServiceProvider).isConnected();
      if (connected) _triggerSync();
    } catch (_) {}
  }

  Future<void> _triggerSync() async {
    if (_isSyncing) return;
    final isConfigured = ref.read(isSupabaseConfiguredProvider);
    if (!isConfigured) return;

    setState(() => _isSyncing = true);
    try {
      await ref.read(syncServiceProvider).syncAll();
      ref.invalidate(allEvidencesProvider);
      ref.invalidate(pendingSyncCountProvider);
    } catch (_) {}
    if (mounted) setState(() => _isSyncing = false);
  }

  void _onBarcodeDetected(String rawValue) {
    if (!mounted) return;
    setState(() => _isProcessing = true);
    context.pushNamed(
      AppRoutes.formBuktiName,
      queryParameters: {AppRoutes.paramResi: rawValue},
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isProcessing = false);
    });
  }

  Future<void> _toggleFlash() async {
    await _scannerService.toggleFlash();
    if (mounted) setState(() => _isFlashOn = _scannerService.isFlashOn);
  }

  void _openManualInput() {
    final controller = TextEditingController();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Input Manual Nomor Resi',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                autofocus: true,
                textCapitalization: TextCapitalization.characters,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Contoh: JP1234567890',
                  hintStyle: const TextStyle(color: Colors.white38),
                  fillColor: Colors.white10,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final resi = controller.text.trim();
                    if (resi.isEmpty) return;
                    Navigator.of(ctx).pop();
                    context.pushNamed(AppRoutes.formBuktiName,
                        queryParameters: {AppRoutes.paramResi: resi});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Lanjutkan',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _scannerService.stop();
    } else if (state == AppLifecycleState.resumed) {
      _scannerService.start();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scannerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isConnectedAsync = ref.watch(isConnectedProvider);
    final pendingCountAsync = ref.watch(pendingSyncCountProvider);
    final isConfigured = ref.watch(isSupabaseConfiguredProvider);

    final isConnected = isConnectedAsync.whenOrNull(data: (v) => v) ?? false;
    final pendingCount = pendingCountAsync.whenOrNull(data: (v) => v) ?? 0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Kamera Scanner
          MobileScanner(
            controller: _scannerService.controller,
            onDetect: _scannerService.onBarcodeDetected,
          ),

          // Overlay frame
          const ScannerOverlayWidget(),

          // AppBar custom
          Positioned(
            top: 0, left: 0, right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Text('PaketVault',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    // Indikator internet
                    if (isConfigured) ...[
                      Icon(
                        isConnected ? Icons.wifi : Icons.wifi_off,
                        color: isConnected ? AppColors.statusSynced : Colors.white38,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      // Badge pending sync
                      if (pendingCount > 0)
                        GestureDetector(
                          onTap: _isSyncing ? null : _triggerSync,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.statusPending.withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: _isSyncing
                                ? const SizedBox(width: 14, height: 14,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                : Text('$pendingCount belum sync',
                                    style: const TextStyle(color: Colors.white, fontSize: 11)),
                          ),
                        )
                      else if (isConnected)
                        const Icon(Icons.cloud_done_outlined,
                            color: AppColors.statusSynced, size: 18),
                      const SizedBox(width: 8),
                    ],
                    GestureDetector(
                      onTap: () => context.pushNamed(AppRoutes.riwayatName),
                      child: const Icon(Icons.history, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => context.pushNamed(AppRoutes.pengaturanName),
                      child: const Icon(Icons.settings_outlined, color: Colors.white, size: 24),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Kontrol bawah
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withValues(alpha: 0.9), Colors.transparent],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ControlButton(
                        icon: _isFlashOn ? Icons.flash_on : Icons.flash_off_outlined,
                        label: _isFlashOn ? 'Flash On' : 'Flash Off',
                        onTap: _toggleFlash,
                        isActive: _isFlashOn,
                      ),
                      _ControlButton(
                        icon: Icons.edit_outlined,
                        label: 'Input Manual',
                        onTap: _openManualInput,
                      ),
                      _ControlButton(
                        icon: Icons.photo_library_outlined,
                        label: 'Foto',
                        onTap: () => context.pushNamed(AppRoutes.riwayatGambarName),
                      ),
                    ],
                  ),
                  if (_isProcessing) ...[
                    const SizedBox(height: 16),
                    const Text('Barcode terdeteksi...',
                        style: TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({required this.icon, required this.label, required this.onTap, this.isActive = false});
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary.withValues(alpha: 0.3) : Colors.white10,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isActive ? AppColors.primary : Colors.transparent),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? AppColors.primaryLight : Colors.white, size: 26),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: isActive ? AppColors.primaryLight : Colors.white70, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
