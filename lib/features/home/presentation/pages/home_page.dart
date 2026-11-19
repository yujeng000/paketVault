import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paketvault/core/routing/app_routes.dart';
import 'package:paketvault/core/theme/app_colors.dart';
import 'package:paketvault/features/delivery/providers/delivery_providers.dart';
import 'package:paketvault/features/sync/providers/sync_providers.dart';

/// Layar awal PaketVault: pilih cara memulai bukti pengiriman.
/// - Scan   : pindai barcode resi, lalu ke form bukti
/// - Kamera : langsung ke form bukti (mulai dari foto, resi diketik)
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    _tryAutoSync();
  }

  /// Auto-sync saat Home dibuka, jika Supabase terkonfigurasi dan ada internet.
  Future<void> _tryAutoSync() async {
    if (!ref.read(isSupabaseConfiguredProvider)) return;
    try {
      final connected = await ref.read(connectivityServiceProvider).isConnected();
      if (connected) _triggerSync();
    } catch (_) {}
  }

  Future<void> _triggerSync() async {
    if (_isSyncing) return;
    if (!ref.read(isSupabaseConfiguredProvider)) return;

    setState(() => _isSyncing = true);
    try {
      await ref.read(syncServiceProvider).syncAll();
      ref.invalidate(allEvidencesProvider);
      ref.invalidate(pendingSyncCountProvider);
    } catch (_) {}
    if (mounted) setState(() => _isSyncing = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isConfigured = ref.watch(isSupabaseConfiguredProvider);
    final isConnected =
        ref.watch(isConnectedProvider).whenOrNull(data: (v) => v) ?? false;
    final pendingCount =
        ref.watch(pendingSyncCountProvider).whenOrNull(data: (v) => v) ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PaketVault',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          if (isConfigured) ...[
            Icon(
              isConnected ? Icons.wifi : Icons.wifi_off,
              color: isConnected ? AppColors.statusSynced : theme.disabledColor,
              size: 18,
            ),
            const SizedBox(width: 8),
            if (pendingCount > 0)
              GestureDetector(
                onTap: _isSyncing ? null : _triggerSync,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.statusPending.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _isSyncing
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : Text('$pendingCount belum sync',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11)),
                ),
              )
            else if (isConnected)
              const Icon(Icons.cloud_done_outlined,
                  color: AppColors.statusSynced, size: 18),
            const SizedBox(width: 8),
          ],
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Riwayat',
            onPressed: () => context.pushNamed(AppRoutes.riwayatName),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Pengaturan',
            onPressed: () => context.pushNamed(AppRoutes.pengaturanName),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Mulai bukti pengiriman',
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('Pilih cara memulai',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.outline)),
              const SizedBox(height: 20),
              Expanded(
                child: _ChoiceCard(
                  icon: Icons.qr_code_scanner,
                  title: 'Scan',
                  subtitle: 'Pindai barcode resi',
                  onTap: () => context.pushNamed(AppRoutes.scannerName),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _ChoiceCard(
                  icon: Icons.photo_camera_outlined,
                  title: 'Kamera',
                  subtitle: 'Mulai dari foto, resi diketik',
                  onTap: () => context.pushNamed(AppRoutes.formBuktiName),
                ),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () =>
                    context.pushNamed(AppRoutes.riwayatGambarName),
                icon: const Icon(Icons.photo_library_outlined),
                label: const Text('Galeri Foto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 56, color: theme.colorScheme.primary),
              const SizedBox(height: 12),
              Text(title,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.outline)),
            ],
          ),
        ),
      ),
    );
  }
}
