import 'dart:math';

/// Membuat UUID versi 4 (acak) tanpa paket tambahan.
/// Dipakai sebagai ID unik bukti dan foto, supaya sinkronisasi ke Supabase
/// tidak bergantung pada nomor urut lokal yang bisa berulang setelah instal ulang.
String generateUuid() {
  final rnd = Random.secure();
  final b = List<int>.generate(16, (_) => rnd.nextInt(256));
  b[6] = (b[6] & 0x0f) | 0x40; // versi 4
  b[8] = (b[8] & 0x3f) | 0x80; // varian RFC 4122
  String h(int v) => v.toRadixString(16).padLeft(2, '0');
  final s = b.map(h).join();
  return '${s.substring(0, 8)}-${s.substring(8, 12)}-${s.substring(12, 16)}-'
      '${s.substring(16, 20)}-${s.substring(20)}';
}
