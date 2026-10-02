import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:paketvault/core/database/isar_database.dart';
import 'package:paketvault/features/delivery/data/models/delivery_evidence.dart';
import 'package:paketvault/features/delivery/data/models/delivery_photo.dart';
import 'package:paketvault/features/delivery/data/repositories/delivery_repository_impl.dart';
import 'package:paketvault/features/delivery/domain/repositories/i_delivery_repository.dart';

final isarProvider = Provider<Isar>((ref) => IsarDatabase.instance);

final deliveryRepositoryProvider = Provider<IDeliveryRepository>((ref) {
  return DeliveryRepositoryImpl(ref.watch(isarProvider));
});

final allEvidencesProvider = FutureProvider<List<DeliveryEvidence>>((ref) async {
  return ref.watch(deliveryRepositoryProvider).getAllEvidences();
});

final evidencePhotosProvider =
    FutureProvider.family<List<DeliveryPhoto>, int>((ref, evidenceId) async {
  return ref.watch(deliveryRepositoryProvider).getPhotosByEvidenceId(evidenceId);
});

final evidenceByIdProvider =
    FutureProvider.family<DeliveryEvidence?, int>((ref, id) async {
  return ref.watch(deliveryRepositoryProvider).getEvidenceById(id);
});
