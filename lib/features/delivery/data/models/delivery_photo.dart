// ignore_for_file: invalid_annotation_target
import 'package:isar_community/isar.dart';

// ⚠️ Jalankan: dart run build_runner build --delete-conflicting-outputs
part 'delivery_photo.g.dart';

@Collection()
class DeliveryPhoto {
  Id id = Isar.autoIncrement;

  @Index()
  late int evidenceId;

  @Index()
  late String evidenceResi;

  late String localPath;

  /// 0=paket, 1=rumah, 2=penerima
  int photoTypeValue = 0;

  late DateTime createdAt;

  /// Path di Supabase Storage — diisi setelah upload
  String? supabaseStoragePath;
}
