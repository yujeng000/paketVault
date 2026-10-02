import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Wrapper terpusat untuk membaca konfigurasi dari file ".env".
/// Tidak ada nilai sensitif yang di-hardcode di source code.
abstract final class EnvConfig {
  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
  }

  // ── Supabase ──────────────────────────────────────────────────────
  /// Cek apakah konfigurasi Supabase sudah lengkap diisi di .env.
  /// Gunakan ini sebelum memanggil Supabase.initialize() di main().
  static bool get isSupabaseConfigured {
    final url = dotenv.maybeGet('SUPABASE_URL') ?? '';
    final key = dotenv.maybeGet('SUPABASE_ANON_KEY') ?? '';
    return url.isNotEmpty && key.isNotEmpty;
  }

  static String get supabaseUrl => _require('SUPABASE_URL');
  static String get supabaseAnonKey => _require('SUPABASE_ANON_KEY');
  static String get storageBucket => _require('STORAGE_BUCKET');
  static String get apiUrl => dotenv.maybeGet('API_URL') ?? '';

  static String _require(String key) {
    final value = dotenv.maybeGet(key);
    if (value == null || value.isEmpty) {
      throw StateError(
        '[EnvConfig] Key "$key" belum diisi di file ".env". '
        'Isi nilai yang benar sebelum menggunakan fitur cloud.',
      );
    }
    return value;
  }
}
