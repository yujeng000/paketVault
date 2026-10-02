import 'package:shared_preferences/shared_preferences.dart';

/// Wrapper terpusat untuk membaca/menulis pengaturan aplikasi.
/// Semua nilai disimpan lokal via SharedPreferences (bukan Isar/Supabase).
///
/// Milestone 4 — Fitur 1: Pengaturan.
class SettingsService {
  const SettingsService(this._prefs);
  final SharedPreferences _prefs;

  // ── GPS ────────────────────────────────────────────────────────
  bool get gpsOtomatis => _prefs.getBool(_kGpsOtomatis) ?? true;
  Future<void> setGpsOtomatis(bool v) => _prefs.setBool(_kGpsOtomatis, v);

  bool get akurasiTinggi => _prefs.getBool(_kAkurasiTinggi) ?? true;
  Future<void> setAkurasiTinggi(bool v) => _prefs.setBool(_kAkurasiTinggi, v);

  bool get gpsRealTime => _prefs.getBool(_kGpsRealTime) ?? false;
  Future<void> setGpsRealTime(bool v) => _prefs.setBool(_kGpsRealTime, v);

  // ── Sinkronisasi ───────────────────────────────────────────────
  bool get uploadOtomatis => _prefs.getBool(_kUploadOtomatis) ?? true;
  Future<void> setUploadOtomatis(bool v) => _prefs.setBool(_kUploadOtomatis, v);

  bool get retryOtomatis => _prefs.getBool(_kRetryOtomatis) ?? true;
  Future<void> setRetryOtomatis(bool v) => _prefs.setBool(_kRetryOtomatis, v);

  // ── Kamera ─────────────────────────────────────────────────────
  bool get flashOtomatis => _prefs.getBool(_kFlashOtomatis) ?? false;
  Future<void> setFlashOtomatis(bool v) => _prefs.setBool(_kFlashOtomatis, v);

  /// 'rendah' | 'sedang' | 'tinggi'
  String get resolusiFoto => _prefs.getString(_kResolusiFoto) ?? 'sedang';
  Future<void> setResolusiFoto(String v) => _prefs.setString(_kResolusiFoto, v);

  // ── Watermark ──────────────────────────────────────────────────
  bool get watermarkEnabled => _prefs.getBool(_kWatermarkEnabled) ?? false;
  Future<void> setWatermarkEnabled(bool v) => _prefs.setBool(_kWatermarkEnabled, v);

  bool get watermarkTanggal => _prefs.getBool(_kWatermarkTanggal) ?? true;
  Future<void> setWatermarkTanggal(bool v) => _prefs.setBool(_kWatermarkTanggal, v);

  bool get watermarkJam => _prefs.getBool(_kWatermarkJam) ?? true;
  Future<void> setWatermarkJam(bool v) => _prefs.setBool(_kWatermarkJam, v);

  bool get watermarkLatitude => _prefs.getBool(_kWatermarkLatitude) ?? true;
  Future<void> setWatermarkLatitude(bool v) => _prefs.setBool(_kWatermarkLatitude, v);

  bool get watermarkLongitude => _prefs.getBool(_kWatermarkLongitude) ?? true;
  Future<void> setWatermarkLongitude(bool v) => _prefs.setBool(_kWatermarkLongitude, v);

  bool get watermarkNamaJalan => _prefs.getBool(_kWatermarkNamaJalan) ?? false;
  Future<void> setWatermarkNamaJalan(bool v) => _prefs.setBool(_kWatermarkNamaJalan, v);

  // ── Penyimpanan ────────────────────────────────────────────────
  /// 0 = nonaktif, atau 3/7/14/30 (hari)
  int get autoDeleteHari => _prefs.getInt(_kAutoDeleteHari) ?? 0;
  Future<void> setAutoDeleteHari(int v) => _prefs.setInt(_kAutoDeleteHari, v);

  static const _kGpsOtomatis = 'settings_gps_otomatis';
  static const _kAkurasiTinggi = 'settings_akurasi_tinggi';
  static const _kGpsRealTime = 'settings_gps_realtime';
  static const _kUploadOtomatis = 'settings_upload_otomatis';
  static const _kRetryOtomatis = 'settings_retry_otomatis';
  static const _kFlashOtomatis = 'settings_flash_otomatis';
  static const _kResolusiFoto = 'settings_resolusi_foto';
  static const _kWatermarkEnabled = 'settings_watermark_enabled';
  static const _kWatermarkTanggal = 'settings_watermark_tanggal';
  static const _kWatermarkJam = 'settings_watermark_jam';
  static const _kWatermarkLatitude = 'settings_watermark_latitude';
  static const _kWatermarkLongitude = 'settings_watermark_longitude';
  static const _kWatermarkNamaJalan = 'settings_watermark_nama_jalan';
  static const _kAutoDeleteHari = 'settings_auto_delete_hari';
}
