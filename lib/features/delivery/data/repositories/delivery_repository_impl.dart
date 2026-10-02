import 'package:isar_community/isar.dart';
import 'package:paketvault/core/constants/sync_status.dart';
import 'package:paketvault/core/errors/app_exception.dart';
import 'package:paketvault/core/utils/file_utils.dart';
import 'package:paketvault/features/delivery/data/models/delivery_evidence.dart';
import 'package:paketvault/features/delivery/data/models/delivery_photo.dart';
import 'package:paketvault/features/delivery/domain/repositories/i_delivery_repository.dart';

class DeliveryRepositoryImpl implements IDeliveryRepository {
  const DeliveryRepositoryImpl(this._isar);
  final Isar _isar;

  @override
  Future<int> saveEvidence(DeliveryEvidence evidence) async {
    try {
      late int savedId;
      await _isar.writeTxn(() async {
        savedId = await _isar.deliveryEvidences.put(evidence);
      });
      return savedId;
    } catch (e) {
      throw DatabaseException('Gagal menyimpan bukti: $e');
    }
  }

  @override
  Future<List<DeliveryEvidence>> getAllEvidences() async {
    try {
      return await _isar.deliveryEvidences.where().sortByWaktuDesc().findAll();
    } catch (e) {
      throw DatabaseException('Gagal mengambil riwayat: $e');
    }
  }

  @override
  Future<DeliveryEvidence?> getEvidenceById(int id) async {
    try {
      return await _isar.deliveryEvidences.get(id);
    } catch (e) {
      throw DatabaseException('Gagal mengambil data: $e');
    }
  }

  @override
  Future<DeliveryEvidence?> getEvidenceByResi(String resi) async {
    try {
      return await _isar.deliveryEvidences.where().resiEqualTo(resi).findFirst();
    } catch (e) {
      throw DatabaseException('Gagal mencari resi: $e');
    }
  }

  @override
  Future<List<DeliveryEvidence>> searchEvidences(String query) async {
    if (query.trim().isEmpty) return getAllEvidences();
    try {
      final lower = query.toLowerCase();
      final all = await _isar.deliveryEvidences.where().sortByWaktuDesc().findAll();
      return all.where((e) {
        return e.resi.toLowerCase().contains(lower) ||
            (e.namaPemilik?.toLowerCase().contains(lower) ?? false) ||
            (e.namaPenerima?.toLowerCase().contains(lower) ?? false) ||
            (e.nomorHp?.contains(lower) ?? false) ||
            (e.catatan?.toLowerCase().contains(lower) ?? false);
      }).toList();
    } catch (e) {
      throw DatabaseException('Gagal mencari data: $e');
    }
  }

  @override
  Future<void> deleteEvidence(int evidenceId) async {
    try {
      final photos = await getPhotosByEvidenceId(evidenceId);
      await _isar.writeTxn(() async {
        await _isar.deliveryPhotos.filter().evidenceIdEqualTo(evidenceId).deleteAll();
        await _isar.deliveryEvidences.delete(evidenceId);
      });
      for (final photo in photos) {
        await FileUtils.deletePhoto(photo.localPath);
      }
    } catch (e) {
      if (e is DatabaseException) rethrow;
      throw DatabaseException('Gagal menghapus bukti: $e');
    }
  }

  @override
  Future<void> updateSyncStatus(int evidenceId, SyncStatus status) async {
    try {
      await _isar.writeTxn(() async {
        final evidence = await _isar.deliveryEvidences.get(evidenceId);
        if (evidence == null) return;
        evidence.syncStatusValue = status.value;
        await _isar.deliveryEvidences.put(evidence);
      });
    } catch (e) {
      throw DatabaseException('Gagal update status sinkronisasi: $e');
    }
  }

  @override
  Future<List<DeliveryEvidence>> getPendingEvidences() async {
    try {
      return await _isar.deliveryEvidences
          .filter()
          .syncStatusValueEqualTo(SyncStatus.pending.value)
          .or()
          .syncStatusValueEqualTo(SyncStatus.failed.value)
          .sortByWaktu()
          .findAll();
    } catch (e) {
      throw DatabaseException('Gagal mengambil data pending: $e');
    }
  }

  @override
  Future<void> updatePhotoStoragePath(int photoId, String storagePath) async {
    try {
      await _isar.writeTxn(() async {
        final photo = await _isar.deliveryPhotos.get(photoId);
        if (photo == null) return;
        photo.supabaseStoragePath = storagePath;
        await _isar.deliveryPhotos.put(photo);
      });
    } catch (e) {
      throw DatabaseException('Gagal update storage path: $e');
    }
  }

  @override
  Future<int> savePhoto(DeliveryPhoto photo) async {
    try {
      late int savedId;
      await _isar.writeTxn(() async {
        savedId = await _isar.deliveryPhotos.put(photo);
      });
      return savedId;
    } catch (e) {
      throw DatabaseException('Gagal menyimpan foto: $e');
    }
  }

  @override
  Future<List<DeliveryPhoto>> getPhotosByEvidenceId(int evidenceId) async {
    try {
      return await _isar.deliveryPhotos
          .filter()
          .evidenceIdEqualTo(evidenceId)
          .findAll();
    } catch (e) {
      throw DatabaseException('Gagal mengambil foto: $e');
    }
  }

  @override
  Future<void> deletePhoto(int photoId) async {
    try {
      DeliveryPhoto? photo;
      await _isar.writeTxn(() async {
        photo = await _isar.deliveryPhotos.get(photoId);
        await _isar.deliveryPhotos.delete(photoId);
      });
      if (photo != null) await FileUtils.deletePhoto(photo!.localPath);
    } catch (e) {
      throw DatabaseException('Gagal menghapus foto: $e');
    }
  }

  @override
  Future<void> deletePhotosByEvidenceId(int evidenceId) async {
    try {
      final photos = await getPhotosByEvidenceId(evidenceId);
      await _isar.writeTxn(() async {
        await _isar.deliveryPhotos
            .filter()
            .evidenceIdEqualTo(evidenceId)
            .deleteAll();
      });
      for (final photo in photos) {
        await FileUtils.deletePhoto(photo.localPath);
      }
    } catch (e) {
      throw DatabaseException('Gagal menghapus semua foto: $e');
    }
  }
}
