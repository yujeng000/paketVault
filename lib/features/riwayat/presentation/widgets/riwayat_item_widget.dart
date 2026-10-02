import 'package:flutter/material.dart';
import 'package:paketvault/core/utils/date_formatter.dart';
import 'package:paketvault/features/delivery/data/models/delivery_evidence.dart';
import 'package:paketvault/features/riwayat/presentation/widgets/sync_status_badge.dart';

class RiwayatItemWidget extends StatelessWidget {
  const RiwayatItemWidget({
    super.key,
    required this.evidence,
    required this.photoCount,
    required this.onTap,
    required this.onDelete,
  });

  final DeliveryEvidence evidence;
  final int photoCount;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(evidence.resi,
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    color: theme.colorScheme.error,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: onDelete,
                    tooltip: 'Hapus',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _Row(icon: Icons.calendar_today_outlined, text: DateFormatter.tanggal(evidence.waktu)),
              const SizedBox(height: 4),
              _Row(icon: Icons.access_time_outlined, text: DateFormatter.jam(evidence.waktu)),
              const SizedBox(height: 4),
              _Row(
                icon: evidence.latitude != null ? Icons.gps_fixed : Icons.gps_off,
                text: evidence.latitude != null ? 'GPS Tersimpan' : 'GPS Tidak Ada',
                color: evidence.latitude != null ? theme.colorScheme.primary : theme.colorScheme.outline,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SyncStatusBadge(statusValue: evidence.syncStatusValue),
                  const Spacer(),
                  Icon(Icons.photo_library_outlined, size: 15, color: theme.colorScheme.outline),
                  const SizedBox(width: 4),
                  Text('$photoCount Foto',
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.icon, required this.text, this.color});
  final IconData icon;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.onSurfaceVariant;
    return Row(children: [
      Icon(icon, size: 14, color: c),
      const SizedBox(width: 6),
      Text(text, style: TextStyle(fontSize: 13, color: c)),
    ]);
  }
}
