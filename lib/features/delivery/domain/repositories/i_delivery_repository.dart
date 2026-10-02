import 'package:paketvault/core/constants/sync_status.dart';
import 'package:paketvault/features/delivery/data/models/delivery_evidence.dart';
import 'package:paketvault/features/delivery/data/models/delivery_photo.dart';

abstract class IDeliveryRepository {
  Future<int> saveEvidence(DeliveryEvidence evidence);
  Future<List<DeliveryEvidence>> getAllEvidences();
  Future<DeliveryEvidence?> getEvidenceById(int id);
  Future<DeliveryEvidence?> getEvidenceByResi(String resi);
  Future<List<DeliveryEvidence>> searchEvidences(String query);
  Future<void> deleteEvidence(int evidenceId);
  Future<void> updateSyncStatus(int evidenceId, SyncStatus status);

  Future<int> savePhoto(DeliveryPhoto photo);
  Future<List<DeliveryPhoto>> getPhotosByEvidenceId(int evidenceId);
  Future<void> deletePhoto(int photoId);
  Future<void> deletePhotosByEvidenceId(int evidenceId);

  /// Ambil semua bukti yang belum tersinkron (pending atau failed).
  Future<List<DeliveryEvidence>> getPendingEvidences();

  /// Simpan storage path foto setelah berhasil upload ke Supabase.
  Future<void> updatePhotoStoragePath(int photoId, String storagePath);
}
