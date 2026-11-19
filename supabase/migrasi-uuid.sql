-- ============================================================
-- PaketVault — Migrasi kunci sinkronisasi: nomor urut lokal -> UUID
-- Jalankan SEKALI di: Supabase Dashboard -> SQL Editor
-- SEBELUM memasang aplikasi versi baru.
-- Data yang sudah ada tidak dihapus.
-- ============================================================

BEGIN;

-- 1. Foto: tambah evidence_id (UUID bukti induk) dan isi dari data lama
ALTER TABLE delivery_photos ADD COLUMN IF NOT EXISTS evidence_id UUID;

UPDATE delivery_photos p
   SET evidence_id = e.id
  FROM delivery_evidences e
 WHERE p.evidence_local_id = e.local_id
   AND p.evidence_id IS NULL;

-- 2. Lepas batasan lama yang bergantung pada nomor urut lokal
ALTER TABLE delivery_photos    DROP CONSTRAINT IF EXISTS delivery_photos_evidence_local_id_fkey;
ALTER TABLE delivery_photos    DROP CONSTRAINT IF EXISTS delivery_photos_local_id_key;
ALTER TABLE delivery_evidences DROP CONSTRAINT IF EXISTS delivery_evidences_local_id_key;
ALTER TABLE delivery_evidences DROP CONSTRAINT IF EXISTS delivery_evidences_resi_key;

-- 3. local_id tinggal informasi (boleh kosong, boleh berulang)
ALTER TABLE delivery_evidences ALTER COLUMN local_id          DROP NOT NULL;
ALTER TABLE delivery_photos    ALTER COLUMN local_id          DROP NOT NULL;
ALTER TABLE delivery_photos    ALTER COLUMN evidence_local_id DROP NOT NULL;

-- 4. Relasi baru berbasis UUID
ALTER TABLE delivery_photos DROP CONSTRAINT IF EXISTS delivery_photos_evidence_id_fkey;
ALTER TABLE delivery_photos
  ADD CONSTRAINT delivery_photos_evidence_id_fkey
  FOREIGN KEY (evidence_id) REFERENCES delivery_evidences(id) ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_delivery_photos_evidence_id ON delivery_photos(evidence_id);

COMMIT;

-- Cek hasil (opsional): daftar batasan yang tersisa.
-- TIDAK boleh ada lagi: *_local_id_key, delivery_evidences_resi_key, delivery_photos_evidence_local_id_fkey
-- SELECT conrelid::regclass AS tabel, conname
--   FROM pg_constraint
--  WHERE conrelid IN ('delivery_evidences'::regclass, 'delivery_photos'::regclass)
--  ORDER BY 1, 2;
