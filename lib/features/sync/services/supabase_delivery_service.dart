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
  /// Path: {resi}/{photoType}_{photoId}.jpg
  /// Mengembalikan storage path (bukan URL publik — bucket bersifat private).
  Future<String> uploadPhoto({
    required String localPath,
    required String resi,
    required int photoType,
    required int photoId,
  }) async {
    try {
      final file = File(localPath);
      if (!await file.exists()) {
        throw SyncException('File foto tidak ditemukan: $localPath');
      }

      final bytes = await file.readAsBytes();
      final typeName = _photoTypeName(photoType);
      final storagePath = '$resi/${typeName}_$photoId.jpg';

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
        onConflict: 'local_id',
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
          'local_id': photo.id,
          'evidence_local_id': photo.evidenceId,
          'evidence_resi': photo.evidenceResi,
          'storage_path': storagePath,
          'photo_type': photo.photoTypeValue,
          'created_at': photo.createdAt.toIso8601String(),
        },
        onConflict: 'local_id',
      );
    } on PostgrestException catch (e) {
      throw SyncException('Gagal sync foto: ${e.message}');
    } catch (e) {
      throw SyncException('Error sync foto: $e');
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
