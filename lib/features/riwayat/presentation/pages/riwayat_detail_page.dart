import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paketvault/core/constants/photo_type.dart';
import 'package:paketvault/core/routing/app_routes.dart';
import 'package:paketvault/core/utils/date_formatter.dart';
import 'package:paketvault/core/utils/map_launcher.dart';
import 'package:paketvault/features/delivery/providers/delivery_providers.dart';
import 'package:paketvault/features/riwayat/presentation/widgets/sync_status_badge.dart';
import 'package:paketvault/features/sync/providers/sync_providers.dart';

class RiwayatDetailPage extends ConsumerWidget {
  const RiwayatDetailPage({super.key, required this.id});
  final String id;

  int? get _evidenceId => int.tryParse(id);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final evidenceId = _evidenceId;
    if (evidenceId == null) {
      return Scaffold(appBar: AppBar(title: const Text('Detail')), body: const Center(child: Text('ID tidak valid')));
    }

    final evidenceAsync = ref.watch(evidenceByIdProvider(evidenceId));
    final photosAsync = ref.watch(evidencePhotosProvider(evidenceId));
    final isConfigured = ref.watch(isSupabaseConfiguredProvider);
    final isConnectedAsync = ref.watch(isConnectedProvider);
    final isConnected = isConnectedAsync.whenOrNull(data: (v) => v) ?? false;

    return Scaffold(
      appBar: AppBar(
        title: evidenceAsync.when(
          data: (e) => Text(e?.resi ?? 'Detail'),
          loading: () => const Text('Memuat...'),
          error: (_, __) => const Text('Error'),
        ),
        actions: [
          // Navigasi ke lokasi penerima (butuh GPS tersimpan)
          evidenceAsync.maybeWhen(
            data: (e) {
              final lat = e?.latitude, lng = e?.longitude;
              if (lat == null || lng == null) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.navigation),
                tooltip: 'Navigasi ke lokasi',
                onPressed: () => MapLauncher.navigateTo(context, lat, lng),
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
          // Sync satu item
          if (isConfigured && isConnected)
            IconButton(
              icon: const Icon(Icons.sync),
              tooltip: 'Sync bukti ini',
              onPressed: () async {
                await ref.read(syncServiceProvider).syncById(evidenceId);
                ref.invalidate(evidenceByIdProvider(evidenceId));
                ref.invalidate(allEvidencesProvider);
                ref.invalidate(pendingSyncCountProvider);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sinkronisasi selesai')));
                }
              },
            ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            color: Colors.white,
            onPressed: () => _confirmDelete(context, ref, evidenceId),
          ),
        ],
      ),
      body: evidenceAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (evidence) {
          if (evidence == null) return const Center(child: Text('Data tidak ditemukan'));
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _Card(children: [
                _Row(label: 'Nomor Resi', value: evidence.resi),
                _Row(label: 'Tanggal', value: DateFormatter.tanggal(evidence.waktu)),
                _Row(label: 'Jam', value: DateFormatter.jam(evidence.waktu)),
                if (evidence.latitude != null)
                  _Row(label: 'GPS', value:
                      '${evidence.latitude!.toStringAsFixed(6)}, ${evidence.longitude!.toStringAsFixed(6)}\n±${evidence.gpsAkurasi!.toStringAsFixed(0)}m'),
              ]),
              const SizedBox(height: 12),
              if (evidence.namaPemilik != null || evidence.namaPenerima != null ||
                  evidence.nomorHp != null || evidence.catatan != null)
                _Card(children: [
                  if (evidence.namaPemilik != null) _Row(label: 'Nama Pemilik', value: evidence.namaPemilik!),
                  if (evidence.namaPenerima != null) _Row(label: 'Nama Penerima', value: evidence.namaPenerima!),
                  if (evidence.nomorHp != null) _Row(label: 'Nomor HP', value: evidence.nomorHp!),
                  if (evidence.catatan != null) _Row(label: 'Catatan', value: evidence.catatan!),
                ]),
              const SizedBox(height: 12),
              _Card(children: [
                Row(children: [
                  const Text('Status', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  SyncStatusBadge(statusValue: evidence.syncStatusValue),
                ]),
              ]),
              const SizedBox(height: 20),
              Text('Foto', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              photosAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Gagal memuat foto: $e'),
                data: (photos) {
                  if (photos.isEmpty) return Text('Tidak ada foto', style: TextStyle(color: Theme.of(context).colorScheme.outline));
                  return Column(
                    children: photos.map((photo) {
                      final type = PhotoType.fromValue(photo.photoTypeValue);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(type.label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(File(photo.localPath), width: double.infinity, fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    height: 120,
                                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                    child: Center(child: Icon(Icons.broken_image_outlined,
                                        color: Theme.of(context).colorScheme.outline, size: 40)),
                                  )),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 48),
            ],
          );
        },
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref, int evidenceId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Bukti?'),
        content: const Text('Semua foto dan data terkait akan dihapus permanen.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Batal')),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: Theme.of(ctx).colorScheme.error),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    try {
      await ref.read(deliveryRepositoryProvider).deleteEvidence(evidenceId);
      ref.invalidate(allEvidencesProvider);
      ref.invalidate(evidenceByIdProvider(evidenceId));
      ref.invalidate(evidencePhotosProvider(evidenceId));
      ref.invalidate(pendingSyncCountProvider);
      if (context.mounted) context.goNamed(AppRoutes.riwayatName);
    } catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal: $e')));
    }
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children)));
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});
  final String label, value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.outline, fontWeight: FontWeight.w500)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 14)),
      ]),
    );
  }
}
