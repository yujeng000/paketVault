import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paketvault/core/routing/app_routes.dart';
import 'package:paketvault/features/delivery/data/models/delivery_evidence.dart';
import 'package:paketvault/features/delivery/providers/delivery_providers.dart';
import 'package:paketvault/features/riwayat/presentation/widgets/riwayat_item_widget.dart';
import 'package:paketvault/features/sync/providers/sync_providers.dart';

class _SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';
  void update(String v) => state = v;
  void clear() => state = '';
}

final _searchQueryProvider =
    NotifierProvider<_SearchQueryNotifier, String>(_SearchQueryNotifier.new);

final _searchResultsProvider =
    FutureProvider<List<DeliveryEvidence>>((ref) async {
  final query = ref.watch(_searchQueryProvider);
  return ref.watch(deliveryRepositoryProvider).searchEvidences(query);
});

class RiwayatPage extends ConsumerWidget {
  const RiwayatPage({super.key});

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, DeliveryEvidence evidence) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Bukti?'),
        content: Text('Bukti "${evidence.resi}" beserta semua foto akan dihapus permanen.'),
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
    if (confirmed != true) return;
    try {
      await ref.read(deliveryRepositoryProvider).deleteEvidence(evidence.id);
      ref.invalidate(allEvidencesProvider);
      ref.invalidate(_searchResultsProvider);
      ref.invalidate(pendingSyncCountProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bukti berhasil dihapus')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Gagal menghapus: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(_searchQueryProvider);
    final evidencesAsync = ref.watch(_searchResultsProvider);
    final isConfigured = ref.watch(isSupabaseConfiguredProvider);
    final isConnectedAsync = ref.watch(isConnectedProvider);
    final isConnected = isConnectedAsync.whenOrNull(data: (v) => v) ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat'),
        actions: [
          // Sync semua tombol (hanya jika Supabase dikonfigurasi dan ada internet)
          if (isConfigured && isConnected)
            IconButton(
              icon: const Icon(Icons.sync),
              tooltip: 'Sync semua',
              onPressed: () async {
                await ref.read(syncServiceProvider).syncAll();
                ref.invalidate(allEvidencesProvider);
                ref.invalidate(_searchResultsProvider);
                ref.invalidate(pendingSyncCountProvider);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sinkronisasi selesai')));
                }
              },
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () {
              ref.invalidate(allEvidencesProvider);
              ref.invalidate(_searchResultsProvider);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              onChanged: (v) => ref.read(_searchQueryProvider.notifier).update(v),
              decoration: InputDecoration(
                hintText: 'Cari resi, nama, HP, catatan...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => ref.read(_searchQueryProvider.notifier).clear())
                    : null,
              ),
            ),
          ),
          Expanded(
            child: evidencesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Gagal memuat: $e')),
              data: (evidences) {
                if (evidences.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(searchQuery.isNotEmpty ? Icons.search_off : Icons.history,
                            size: 64, color: Theme.of(context).colorScheme.outline),
                        const SizedBox(height: 16),
                        Text(
                          searchQuery.isNotEmpty
                              ? 'Tidak ada hasil untuk "$searchQuery"'
                              : 'Belum ada riwayat.',
                          style: TextStyle(color: Theme.of(context).colorScheme.outline),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  itemCount: evidences.length,
                  itemBuilder: (_, i) => _ItemWithPhotos(
                    evidence: evidences[i],
                    onTap: () => context.goNamed(AppRoutes.riwayatDetailName,
                        pathParameters: {'id': evidences[i].id.toString()}),
                    onDelete: () => _confirmDelete(context, ref, evidences[i]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemWithPhotos extends ConsumerWidget {
  const _ItemWithPhotos({required this.evidence, required this.onTap, required this.onDelete});
  final DeliveryEvidence evidence;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(evidencePhotosProvider(evidence.id));
    final photoCount = photosAsync.whenOrNull(data: (p) => p.length) ?? 0;
    return RiwayatItemWidget(evidence: evidence, photoCount: photoCount, onTap: onTap, onDelete: onDelete);
  }
}
