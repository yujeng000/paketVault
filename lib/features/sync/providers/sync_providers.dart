import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:paketvault/core/config/env_config.dart';
import 'package:paketvault/core/constants/sync_status.dart';
import 'package:paketvault/core/services/connectivity_service.dart';
import 'package:paketvault/features/delivery/providers/delivery_providers.dart';
import 'package:paketvault/features/sync/services/supabase_delivery_service.dart';
import 'package:paketvault/features/sync/services/sync_service.dart';

// ── Connectivity ──────────────────────────────────────────────────────────────

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

/// Stream: true = ada internet, false = tidak ada.
final isConnectedProvider = StreamProvider<bool>((ref) {
  return ref.watch(connectivityServiceProvider).onConnectivityChanged;
});

/// Cek koneksi saat ini (satu kali).
final currentConnectivityProvider = FutureProvider<bool>((ref) {
  return ref.watch(connectivityServiceProvider).isConnected();
});

// ── Supabase ──────────────────────────────────────────────────────────────────

/// Provider SupabaseDeliveryService.
/// Throws jika Supabase belum dikonfigurasi di .env.
final supabaseDeliveryServiceProvider =
    Provider<SupabaseDeliveryService>((ref) {
  return SupabaseDeliveryService(
    client: Supabase.instance.client,
    bucket: EnvConfig.storageBucket,
  );
});

// ── Sync ──────────────────────────────────────────────────────────────────────

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(
    repo: ref.watch(deliveryRepositoryProvider),
    supabaseService: ref.watch(supabaseDeliveryServiceProvider),
  );
});

/// Jumlah evidence yang belum tersinkron (pending atau failed).
final pendingSyncCountProvider = FutureProvider<int>((ref) async {
  // Watch allEvidencesProvider agar angka update saat data berubah
  final evidences = await ref.watch(allEvidencesProvider.future);
  return evidences
      .where((e) =>
          e.syncStatusValue == SyncStatus.pending.value ||
          e.syncStatusValue == SyncStatus.failed.value)
      .length;
});

/// Apakah Supabase sudah dikonfigurasi di .env.
final isSupabaseConfiguredProvider = Provider<bool>((ref) {
  return EnvConfig.isSupabaseConfigured;
});
