enum PhotoType {
  paket(0, 'Foto Paket'),
  rumah(1, 'Foto Rumah/Gedung'),
  penerima(2, 'Foto Penerima');

  const PhotoType(this.value, this.label);
  final int value;
  final String label;

  static PhotoType fromValue(int value) => PhotoType.values.firstWhere(
        (e) => e.value == value,
        orElse: () => PhotoType.paket,
      );
}
