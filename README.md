# PaketVault — v0.3 (Milestone 3)

Aplikasi kurir offline-first dengan cloud sync ke Supabase.

---

## ⚠️ Langkah Build Wajib (Urutan Penting)

```bash
# 1. Install dependency
flutter pub get

# 2. Generate kode Isar (WAJIB sebelum build pertama)
dart run build_runner build --delete-conflicting-outputs

# 3. Analisa kode
flutter analyze

# 4. Build APK debug
flutter build apk --debug
```

---

## Setup Supabase (Isi sebelum fitur sync digunakan)

### Langkah 1 — Isi file `.env`
```env
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
STORAGE_BUCKET=delivery-photos
```
Nilai ini ada di: **Supabase Dashboard → Settings → API**

### Langkah 2 — Buat tabel database
Jalankan isi file `supabase/schema.sql` di:
**Supabase Dashboard → SQL Editor → New query → Run**

### Langkah 3 — Buat Storage Bucket
Di **Supabase Dashboard → Storage → New Bucket**:
- Nama: sesuai `STORAGE_BUCKET` di `.env` (contoh: `delivery-photos`)
- Type: **Private** (bukan Public)

Setelah 3 langkah ini, fitur sync otomatis aktif saat app dibuka.

---

## Environment Baseline (Dikunci)

| Item | Versi |
|---|---|
| Flutter | Stable 3.44.0 |
| Dart | 3.12.0 |
| Android SDK | 36 / minSdk 23 |
| AGP | 9.0.1 / Kotlin 2.3.20 / Gradle 9.1.0 |

---

## Package Milestone 3 (Baru)

| Package | Versi | Fungsi |
|---|---|---|
| `supabase_flutter` | `2.8.4` | Supabase client (storage + database) |
| `connectivity_plus` | `6.1.4` | Monitor koneksi internet |

---

## Fitur Milestone 3

- ✅ Inisialisasi Supabase dari `.env` (aman — tidak berjalan jika belum diisi)
- ✅ Upload foto ke Supabase Storage (Private Bucket)
- ✅ Sync metadata ke PostgreSQL Supabase
- ✅ Status sinkronisasi real-time (🟢🟡🔴)
- ✅ Auto-sync saat app dibuka (jika internet tersedia)
- ✅ Sync per item dari halaman Detail
- ✅ Sync semua dari halaman Riwayat
- ✅ Indikator internet di Scanner page
- ✅ Badge pending sync di Scanner page
- ✅ INTERNET + ACCESS_NETWORK_STATE permission

---

## Struktur Folder

```
lib/
├── main.dart                          # Init EnvConfig + Isar + Supabase
├── core/
│   ├── config/env_config.dart         # isSupabaseConfigured (baru)
│   ├── services/connectivity_service.dart  # Monitor internet (baru)
│   └── ...
└── features/
    ├── sync/
    │   ├── services/
    │   │   ├── supabase_delivery_service.dart  # Upload & upsert (baru)
    │   │   └── sync_service.dart               # Orkestrasi sync (baru)
    │   └── providers/
    │       └── sync_providers.dart             # Riverpod providers (baru)
    └── ...

supabase/
└── schema.sql    # Jalankan di Supabase SQL Editor
```
