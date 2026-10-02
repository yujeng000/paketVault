-- ============================================================
-- PaketVault — Supabase Database Schema
-- Jalankan SQL ini di: Supabase Dashboard → SQL Editor
-- ============================================================

-- Tabel bukti pengiriman utama
CREATE TABLE IF NOT EXISTS delivery_evidences (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  local_id      BIGINT NOT NULL UNIQUE,        -- ID dari Isar lokal
  resi          TEXT NOT NULL UNIQUE,          -- Nomor resi (unique)
  nama_pemilik  TEXT,
  nama_penerima TEXT,
  nomor_hp      TEXT,
  catatan       TEXT,
  latitude      DOUBLE PRECISION,
  longitude     DOUBLE PRECISION,
  gps_akurasi   DOUBLE PRECISION,
  waktu         TIMESTAMPTZ NOT NULL,          -- Waktu pengiriman
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Tabel foto bukti pengiriman
CREATE TABLE IF NOT EXISTS delivery_photos (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  local_id          BIGINT NOT NULL UNIQUE,    -- ID dari Isar lokal
  evidence_local_id BIGINT NOT NULL
    REFERENCES delivery_evidences(local_id) ON DELETE CASCADE,
  evidence_resi     TEXT NOT NULL,
  storage_path      TEXT,                      -- Path di Supabase Storage
  photo_type        INTEGER NOT NULL,          -- 0=paket, 1=rumah, 2=penerima
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Index untuk mempercepat query
CREATE INDEX IF NOT EXISTS idx_delivery_evidences_resi    ON delivery_evidences(resi);
CREATE INDEX IF NOT EXISTS idx_delivery_evidences_waktu   ON delivery_evidences(waktu DESC);
CREATE INDEX IF NOT EXISTS idx_delivery_photos_evidence   ON delivery_photos(evidence_local_id);

-- ============================================================
-- Row Level Security (RLS)
-- Untuk aplikasi personal tanpa auth, nonaktifkan RLS.
-- Milestone 4 akan menambahkan auth + RLS jika diperlukan.
-- ============================================================
ALTER TABLE delivery_evidences DISABLE ROW LEVEL SECURITY;
ALTER TABLE delivery_photos    DISABLE ROW LEVEL SECURITY;

-- ============================================================
-- Storage Bucket
-- Buat manual di: Supabase Dashboard → Storage → New Bucket
-- Nama bucket: sesuai STORAGE_BUCKET di file .env
-- Type: Private (bukan Public)
-- ============================================================
