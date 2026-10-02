enum SyncStatus {
  pending(0, '🟡 Menunggu Sinkron'),
  synced(1, '🟢 Tersinkron'),
  failed(2, '🔴 Gagal Sinkron');

  const SyncStatus(this.value, this.label);
  final int value;
  final String label;

  static SyncStatus fromValue(int value) => SyncStatus.values.firstWhere(
        (e) => e.value == value,
        orElse: () => SyncStatus.pending,
      );
}
