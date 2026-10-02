import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paketvault/core/constants/photo_type.dart';
import 'package:paketvault/features/delivery/data/models/delivery_evidence.dart';
import 'package:paketvault/features/delivery/data/models/delivery_photo.dart';
import 'package:paketvault/features/delivery/providers/delivery_providers.dart';

class RiwayatGambarPage extends ConsumerWidget {
  const RiwayatGambarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final evidencesAsync = ref.watch(allEvidencesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Gambar'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => ref.invalidate(allEvidencesProvider)),
        ],
      ),
      body: evidencesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Gagal memuat: $e')),
        data: (evidences) {
          if (evidences.isEmpty) {
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.photo_library_outlined, size: 64, color: Theme.of(context).colorScheme.outline),
                const SizedBox(height: 16),
                Text('Belum ada foto tersimpan.', style: TextStyle(color: Theme.of(context).colorScheme.outline)),
              ]),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: evidences.length,
            itemBuilder: (_, i) => _EvidencePhotoGroup(evidence: evidences[i]),
          );
        },
      ),
    );
  }
}

class _EvidencePhotoGroup extends ConsumerWidget {
  const _EvidencePhotoGroup({required this.evidence});
  final DeliveryEvidence evidence;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(evidencePhotosProvider(evidence.id));
    final theme = Theme.of(context);
    return photosAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (photos) {
        if (photos.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(evidence.resi,
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
              itemCount: photos.length,
              itemBuilder: (_, i) => _PhotoThumbnail(photo: photos[i]),
            ),
            const Divider(height: 24),
          ],
        );
      },
    );
  }
}

class _PhotoThumbnail extends StatelessWidget {
  const _PhotoThumbnail({required this.photo});
  final DeliveryPhoto photo;

  @override
  Widget build(BuildContext context) {
    final type = PhotoType.fromValue(photo.photoTypeValue);
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(File(photo.localPath), fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.broken_image_outlined, size: 24),
              )),
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter, end: Alignment.topCenter,
                  colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent],
                ),
              ),
              child: Text(type.label.replaceAll('Foto ', ''),
                  style: const TextStyle(color: Colors.white, fontSize: 9), textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }
}
