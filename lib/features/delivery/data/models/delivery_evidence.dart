// ignore_for_file: invalid_annotation_target
import 'package:isar_community/isar.dart';

// ⚠️ Jalankan: dart run build_runner build --delete-conflicting-outputs
part 'delivery_evidence.g.dart';

@Collection()
class DeliveryEvidence {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String resi;

  String? namaPemilik;
  String? namaPenerima;
  String? nomorHp;
  String? catatan;

  double? latitude;
  double? longitude;
  double? gpsAkurasi;

  @Index()
  late DateTime waktu;

  /// 0=pending, 1=synced, 2=failed
  int syncStatusValue = 0;

  /// Diisi setelah sync ke Supabase
  String? supabaseId;

  /// ID unik (UUID v4) — kunci sinkronisasi ke Supabase.
  /// Kosong pada data lama; diisi otomatis saat sinkronisasi berikutnya.
  String uuid = '';
}
