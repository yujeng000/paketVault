import 'package:flutter/material.dart';
import 'package:paketvault/core/constants/sync_status.dart';
import 'package:paketvault/core/theme/app_colors.dart';

class SyncStatusBadge extends StatelessWidget {
  const SyncStatusBadge({super.key, required this.statusValue});
  final int statusValue;

  @override
  Widget build(BuildContext context) {
    final status = SyncStatus.fromValue(statusValue);
    final (color, icon) = switch (status) {
      SyncStatus.synced => (AppColors.statusSynced, Icons.cloud_done_outlined),
      SyncStatus.pending => (AppColors.statusPending, Icons.cloud_upload_outlined),
      SyncStatus.failed => (AppColors.statusFailed, Icons.cloud_off_outlined),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(status.label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
