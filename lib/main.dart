import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:paketvault/core/config/env_config.dart';
import 'package:paketvault/core/database/isar_database.dart';
import 'package:paketvault/core/routing/app_router.dart';
import 'package:paketvault/core/theme/app_theme.dart';
import 'package:paketvault/features/pengaturan/providers/pengaturan_providers.dart';

/// Entry point PaketVault — Milestone 4.
///
/// Urutan inisialisasi:
/// 1. WidgetsFlutterBinding
/// 2. EnvConfig.load()   — muat file .env
/// 3. IsarDatabase       — init database lokal
/// 4. Supabase           — init cloud (hanya jika .env sudah diisi)
/// 5. SharedPreferences  — init Pengaturan
/// 6. runApp
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Muat konfigurasi dari .env
  await EnvConfig.load();

  // 2. Init database lokal Isar
  // ⚠️ Pastikan sudah menjalankan:
  //    dart run build_runner build --delete-conflicting-outputs
  await IsarDatabase.initialize();

  // 3. Init Supabase — hanya jika SUPABASE_URL dan SUPABASE_ANON_KEY sudah diisi
  // Aman dipanggil berulang kali (idempotent sejak supabase_flutter 2.x)
  if (EnvConfig.isSupabaseConfigured) {
    await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
    );
  }

  // 4. Init SharedPreferences — Milestone 4: Pengaturan
  final prefs = await SharedPreferences.getInstance();

  runApp(ProviderScope(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    child: const PaketVaultApp(),
  ));
}

class PaketVaultApp extends ConsumerWidget {
  const PaketVaultApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'PaketVault',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
