import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paketvault/features/delivery/data/models/delivery_evidence.dart';
import 'package:paketvault/features/delivery/data/models/delivery_photo.dart';

class IsarDatabase {
  IsarDatabase._();

  static Isar? _instance;

  static Future<Isar> initialize() async {
    if (_instance != null && _instance!.isOpen) return _instance!;
    final dir = await getApplicationDocumentsDirectory();
    _instance = await Isar.open(
      [DeliveryEvidenceSchema, DeliveryPhotoSchema],
      directory: dir.path,
      name: 'paketvault_db',
    );
    return _instance!;
  }

  static Isar get instance {
    if (_instance == null || !_instance!.isOpen) {
      throw StateError('IsarDatabase belum diinisialisasi.');
    }
    return _instance!;
  }

  static Future<void> close() async {
    await _instance?.close();
    _instance = null;
  }
}
