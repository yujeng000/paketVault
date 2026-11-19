import 'package:flutter/foundation.dart';
import 'package:paketvault/core/constants/sync_status.dart';
import 'package:paketvault/core/errors/app_exception.dart';
import 'package:paketvault/core/utils/uuid_util.dart';
import 'package:paketvault/features/delivery/data/models/delivery_evidence.dart';
import 'package:paketvault/features/delivery/domain/repositories/i_delivery_repository.dart';
import 'package:paketvault/features/sync/services/supabase_delivery_service.dart';

/// Service yang mengorkestrasikan sinkronisasi data lokal ke Supabase.
///
/// Alur sync per evidence:
/// 1. Upload setiap foto ke Supabase Storage
/// 2. Upsert metadata evidence ke PostgreSQL
/// 3. Upsert metadata setiap foto ke PostgreSQL
/// 4. Update syncStatus di Isar → synced
///
/// Jika gagal di langkah manapun → syncStatus → failed (akan di-retry nanti)
class SyncService {
  const SyncService({
    required IDeliveryRepository repo,
    required SupabaseDeliveryService supabaseService,
  })  : _repo = repo,
        _supabase = supabaseService;

  final IDeliveryRepository _repo;
  final SupabaseDeliveryService _supabase;

  /// Sync semua evidence yang statusnya pending atau failed.
  /// Fire-and-forget — panggil tanpa await jika tidak perlu menunggu selesai.
  Future<SyncResult> syncAll() async {
    int success = 0;
    int failed = 0;

    try {
      final pending = await _repo.getPendingEvidences();
      for (final evidence in pending) {
        final ok = await _syncEvidence(evidence);
        if (ok) {
          success++;
        } else {
          failed++;
        }
      }
    } catch (e) {
      // Error global — tidak membatalkan proses
    }

    return SyncResult(success: success, failed: failed);
  }

  /// Sync satu evidence. Mengembalikan true jika berhasil.
  Future<bool> _syncEvidence(DeliveryEvidence evidence) async {
    try {
      // 0. Pastikan bukti dan fotonya punya UUID. Data lama (dibuat sebelum ada UUID)
      //    memakai ID baris lama di cloud bila ada, jika tidak dibuatkan UUID baru.
      if (evidence.uuid.isEmpty) {
        evidence.uuid =
            await _supabase.findLegacyEvidenceId(evidence) ?? generateUuid();
        await _repo.saveEvidence(evidence);
      }
      final photos = await _repo.getPhotosByEvidenceId(evidence.id);
      for (final photo in photos) {
        if (photo.uuid.isNotEmpty && photo.evidenceUuid == evidence.uuid) continue;
        if (photo.uuid.isEmpty) {
          photo.uuid =
              await _supabase.findLegacyPhotoId(photo) ?? generateUuid();
        }
        photo.evidenceUuid = evidence.uuid;
        await _repo.savePhoto(photo);
      }

      // 1. Upload setiap foto ke Storage
      for (final photo in photos) {
        if (photo.supabaseStoragePath != null) continue; // sudah terupload

        final storagePath = await _supabase.uploadPhoto(
          localPath: photo.localPath,
          resi: evidence.resi,
          photoType: photo.photoTypeValue,
          photoUuid: photo.uuid,
        );

        // Simpan storage path di Isar
        await _repo.updatePhotoStoragePath(photo.id, storagePath);
      }

      // 2. Upsert evidence metadata ke PostgreSQL
      await _supabase.upsertEvidence(evidence);

      // 3. Upsert foto metadata ke PostgreSQL
      final updatedPhotos = await _repo.getPhotosByEvidenceId(evidence.id);
      for (final photo in updatedPhotos) {
        if (photo.supabaseStoragePath == null) continue;
        await _supabase.upsertPhoto(
          photo: photo,
          storagePath: photo.supabaseStoragePath!,
        );
      }

      // 4. Update status → synced
      await _repo.updateSyncStatus(evidence.id, SyncStatus.synced);
      return true;
    } on SyncException catch (e) {
      debugPrint('[SYNC] gagal (${evidence.resi}): $e');
      await _repo.updateSyncStatus(evidence.id, SyncStatus.failed);
      return false;
    } catch (e) {
      debugPrint('[SYNC] error (${evidence.resi}): $e');
      await _repo.updateSyncStatus(evidence.id, SyncStatus.failed);
      return false;
    }
  }

  /// Sync satu evidence berdasarkan ID (dipanggil langsung setelah simpan form).
  Future<bool> syncById(int evidenceId) async {
    try {
      final evidence = await _repo.getEvidenceById(evidenceId);
      if (evidence == null) return false;
      return _syncEvidence(evidence);
    } catch (_) {
      return false;
    }
  }
}

class SyncResult {
  const SyncResult({required this.success, required this.failed});
  final int success;
  final int failed;
  bool get hasErrors => failed > 0;
}
