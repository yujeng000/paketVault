import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:paketvault/core/errors/app_exception.dart';
import 'package:paketvault/features/delivery/data/models/delivery_evidence.dart';
import 'package:paketvault/features/delivery/data/models/delivery_photo.dart';

/// Service untuk operasi Supabase:
/// - Upload foto ke Storage (Private Bucket)
/// - Upsert metadata ke PostgreSQL
///
/// Konfigurasi dari .env:
/// - SUPABASE_URL
/// - SUPABASE_ANON_KEY
/// - STORAGE_BUCKET
class SupabaseDeliveryService {
  const SupabaseDeliveryService({
    required this.client,
    required this.bucket,
  });

  final SupabaseClient client;
  final String bucket;

  // ── Storage ──────────────────────────────────────────────────────

  /// Upload foto ke Supabase Storage.
  /// Path: {resi}/{photoType}_{photoUuid}.jpg
  /// Mengembalikan storage path (bukan URL publik — bucket bersifat private).
  Future<String> uploadPhoto({
    required String localPath,
    required String resi,
    required int photoType,
    required String photoUuid,
  }) async {
    try {
      final file = File(localPath);
      if (!await file.exists()) {
        throw SyncException('File foto tidak ditemukan: $localPath');
      }

      final bytes = await file.readAsBytes();
      final typeName = _photoTypeName(photoType);
      final storagePath = '$resi/${typeName}_$photoUuid.jpg';

      await client.storage.from(bucket).uploadBinary(
        storagePath,
        bytes,
        fileOptions: const FileOptions(
          contentType: 'image/jpeg',
          upsert: true,
        ),
      );

      return storagePath;
    } on StorageException catch (e) {
      throw SyncException('Gagal upload foto: ${e.message}');
    } catch (e) {
      if (e is SyncException) rethrow;
      throw SyncException('Error upload foto: $e');
    }
  }

  /// Hapus foto dari Supabase Storage.
  Future<void> deletePhoto(String storagePath) async {
    try {
      await client.storage.from(bucket).remove([storagePath]);
    } catch (_) {
      // Abaikan error hapus — tidak blocking
    }
  }

  // ── Database ─────────────────────────────────────────────────────

  /// Upsert data bukti pengiriman ke tabel delivery_evidences.
  Future<void> upsertEvidence(DeliveryEvidence evidence) async {
    try {
      await client.from('delivery_evidences').upsert(
        {
          'id': evidence.uuid,
          'local_id': evidence.id,
          'resi': evidence.resi,
          'nama_pemilik': evidence.namaPemilik,
          'nama_penerima': evidence.namaPenerima,
          'nomor_hp': evidence.nomorHp,
          'catatan': evidence.catatan,
          'latitude': evidence.latitude,
          'longitude': evidence.longitude,
          'gps_akurasi': evidence.gpsAkurasi,
          'waktu': evidence.waktu.toIso8601String(),
        },
        onConflict: 'id',
      );
    } on PostgrestException catch (e) {
      throw SyncException('Gagal sync evidence: ${e.message}');
    } catch (e) {
      throw SyncException('Error sync evidence: $e');
    }
  }

  /// Upsert data foto ke tabel delivery_photos.
  Future<void> upsertPhoto({
    required DeliveryPhoto photo,
    required String storagePath,
  }) async {
    try {
      await client.from('delivery_photos').upsert(
        {
          'id': photo.uuid,
          'evidence_id': photo.evidenceUuid,
          'local_id': photo.id,
          'evidence_local_id': photo.evidenceId,
          'evidence_resi': photo.evidenceResi,
          'storage_path': storagePath,
          'photo_type': photo.photoTypeValue,
          'created_at': photo.createdAt.toIso8601String(),
        },
        onConflict: 'id',
      );
    } on PostgrestException catch (e) {
      throw SyncException('Gagal sync foto: ${e.message}');
    } catch (e) {
      throw SyncException('Error sync foto: $e');
    }
  }

  /// Cari ID (UUID) baris lama di cloud untuk bukti yang dibuat sebelum ada UUID lokal,
  /// supaya tidak terbentuk baris ganda. Mengembalikan null jika memang belum ada.
  Future<String?> findLegacyEvidenceId(DeliveryEvidence evidence) async {
    try {
      final row = await client
          .from('delivery_evidences')
          .select('id')
          .eq('resi', evidence.resi)
          .eq('local_id', evidence.id)
          .maybeSingle();
      return row?['id'] as String?;
    } on PostgrestException catch (e) {
      throw SyncException('Gagal cek data lama: ${e.message}');
    } catch (e) {
      throw SyncException('Error cek data lama: $e');
    }
  }

  /// Sama seperti di atas, untuk foto.
  Future<String?> findLegacyPhotoId(DeliveryPhoto photo) async {
    try {
      final row = await client
          .from('delivery_photos')
          .select('id')
          .eq('evidence_resi', photo.evidenceResi)
          .eq('local_id', photo.id)
          .maybeSingle();
      return row?['id'] as String?;
    } on PostgrestException catch (e) {
      throw SyncException('Gagal cek foto lama: ${e.message}');
    } catch (e) {
      throw SyncException('Error cek foto lama: $e');
    }
  }

  /// Hapus evidence dari Supabase (cascade ke photos via FK).
  Future<void> deleteEvidence(String resi) async {
    try {
      await client.from('delivery_evidences').delete().eq('resi', resi);
    } catch (_) {
      // Abaikan — tidak blocking
    }
  }

  // ── Helper ───────────────────────────────────────────────────────

  String _photoTypeName(int type) {
    switch (type) {
      case 0:
        return 'paket';
      case 1:
        return 'rumah';
      case 2:
        return 'penerima';
      default:
        return 'foto';
    }
  }
}
