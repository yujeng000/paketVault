# Changelog — PaketVault

## [0.3.0] — Milestone 3: Cloud Sync

### Package baru
- `supabase_flutter: 2.8.4`
- `connectivity_plus: 6.1.4`

### Ditambahkan
- `EnvConfig.isSupabaseConfigured` — cek sebelum init Supabase
- `ConnectivityService` — monitor internet (connectivity_plus 6.x API)
- `SupabaseDeliveryService` — upload foto + upsert metadata ke Supabase
- `SyncService` — orkestrasi sync (upload → metadata → update status Isar)
- `sync_providers.dart` — Riverpod providers: connectivity, sync, pending count
- Auto-sync saat app dibuka (ScannerPage)
- Sync manual per item (RiwayatDetailPage)
- Sync semua dari RiwayatPage (jika internet tersedia)
- Badge pending sync di ScannerPage
- Indikator internet di ScannerPage
- INTERNET + ACCESS_NETWORK_STATE di AndroidManifest
- `supabase/schema.sql` — schema tabel delivery_evidences + delivery_photos
- `IDeliveryRepository.getPendingEvidences()` — method baru
- `IDeliveryRepository.updatePhotoStoragePath()` — simpan storage path setelah upload
- `DeliveryPhoto.supabaseStoragePath` — field baru di model Isar
- `SyncException` di AppException hierarchy

### Diubah
- `main.dart` — tambah `EnvConfig.load()` dan `Supabase.initialize()` (conditional)
- `scanner_page.dart` — tampilkan status internet + badge pending sync
- `form_bukti_page.dart` — trigger sync background setelah simpan
- `riwayat_page.dart` — tombol sync semua
- `riwayat_detail_page.dart` — tombol sync item ini

---

## [0.2.0] — Milestone 2: Fitur Offline Inti ✅
Scanner, Kamera, GPS, Isar, Form Bukti, Riwayat, Popup Sukses

## [0.1.0] — Milestone 1: Fondasi ✅
Struktur, Config, Theme, Routing
