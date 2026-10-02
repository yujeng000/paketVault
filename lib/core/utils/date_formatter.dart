abstract final class DateFormatter {
  DateFormatter._();

  static const List<String> _bulanIndo = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
  ];

  static String tanggal(DateTime dt) {
    final hari = dt.day.toString().padLeft(2, '0');
    final bulan = _bulanIndo[dt.month - 1];
    return '$hari $bulan ${dt.year}';
  }

  static String jam(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  static String tanggalJam(DateTime dt) => '${tanggal(dt)} • ${jam(dt)}';
}
