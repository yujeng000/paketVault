import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paketvault/core/services/settings_service.dart';
import 'package:paketvault/features/pengaturan/providers/pengaturan_providers.dart';

class PengaturanPage extends ConsumerWidget {
  const PengaturanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(settingsRevisionProvider);
    final settings = ref.watch(settingsServiceProvider);
    final notifier = ref.read(settingsRevisionProvider.notifier);
    final theme = Theme.of(context);

    Future<void> toggle(Future<void> Function(bool) setter, bool value) async {
      await setter(value);
      notifier.bump();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        children: [
          _Section('Kamera', [
            _Tile(
              Icons.flash_on_outlined,
              'Flash Otomatis',
              trailing: Switch(
                value: settings.flashOtomatis,
                onChanged: (v) => toggle(settings.setFlashOtomatis, v),
              ),
            ),
            _Tile(
              Icons.photo_size_select_actual_outlined,
              'Resolusi & Kualitas',
              subtitle: _resolusiLabel(settings.resolusiFoto),
              onTap: () => _showResolusiDialog(context, settings, notifier),
            ),
            _Tile(
              Icons.water_outlined,
              'Watermark',
              subtitle: settings.watermarkEnabled ? 'Aktif' : 'Nonaktif',
              onTap: () => _showWatermarkSheet(context, settings, notifier),
            ),
          ]),
          _Section('Lokasi', [
            _Tile(
              Icons.gps_fixed,
              'GPS Otomatis',
              subtitle: 'Ambil lokasi otomatis saat membuka Form Bukti',
              trailing: Switch(
                value: settings.gpsOtomatis,
                onChanged: (v) => toggle(settings.setGpsOtomatis, v),
              ),
            ),
            _Tile(
              Icons.my_location,
              'Akurasi Tinggi',
              trailing: Switch(
                value: settings.akurasiTinggi,
                onChanged: (v) => toggle(settings.setAkurasiTinggi, v),
              ),
            ),
            _Tile(
              Icons.satellite_alt_outlined,
              'GPS Real-Time',
              subtitle: 'Perbarui lokasi terus-menerus selama form dibuka',
              trailing: Switch(
                value: settings.gpsRealTime,
                onChanged: (v) => toggle(settings.setGpsRealTime, v),
              ),
            ),
          ]),
          _Section('Sinkronisasi', [
            _Tile(
              Icons.cloud_upload_outlined,
              'Upload Otomatis',
              subtitle: 'Sinkron ke cloud otomatis setelah simpan bukti',
              trailing: Switch(
                value: settings.uploadOtomatis,
                onChanged: (v) => toggle(settings.setUploadOtomatis, v),
              ),
            ),
            _Tile(
              Icons.replay,
              'Retry Otomatis',
              subtitle: 'Coba ulang sinkron yang gagal',
              trailing: Switch(
                value: settings.retryOtomatis,
                onChanged: (v) => toggle(settings.setRetryOtomatis, v),
              ),
            ),
          ]),
          _Section('Penyimpanan', [
            _Tile(
              Icons.auto_delete_outlined,
              'Hapus Otomatis',
              subtitle: _autoDeleteLabel(settings.autoDeleteHari),
              onTap: () => _showAutoDeleteDialog(context, settings, notifier),
            ),
          ]),
          _Section('Keamanan', [
            _Tile(Icons.lock_outline, 'PIN'),
            _Tile(Icons.fingerprint, 'Sidik Jari'),
            _Tile(Icons.lock_clock_outlined, 'Auto Lock'),
          ]),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'Keamanan (PIN/Sidik Jari) — tahap berikutnya',
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  static String _resolusiLabel(String v) => switch (v) {
        'rendah' => 'Rendah',
        'tinggi' => 'Tinggi',
        _ => 'Sedang',
      };

  static String _autoDeleteLabel(int hari) =>
      hari == 0 ? 'Nonaktif' : 'Setelah $hari hari';

  static Future<void> _showResolusiDialog(
      BuildContext context, SettingsService settings, SettingsRevisionNotifier notifier) async {
    final options = const [('rendah', 'Rendah'), ('sedang', 'Sedang'), ('tinggi', 'Tinggi')];
    final selected = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Resolusi & Kualitas Foto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((opt) {
            return RadioListTile<String>(
              title: Text(opt.$2),
              value: opt.$1,
              groupValue: settings.resolusiFoto,
              onChanged: (v) => Navigator.of(ctx).pop(v),
            );
          }).toList(),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Batal')),
        ],
      ),
    );
    if (selected != null) {
      await settings.setResolusiFoto(selected);
      notifier.bump();
    }
  }

  static Future<void> _showAutoDeleteDialog(
      BuildContext context, SettingsService settings, SettingsRevisionNotifier notifier) async {
    final options = const [(0, 'Nonaktif'), (3, '3 hari'), (7, '7 hari'), (14, '14 hari'), (30, '30 hari')];
    final selected = await showDialog<int>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Otomatis'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text('Data lokal & cloud akan dihapus otomatis setelah periode ini.',
                  style: TextStyle(fontSize: 12)),
            ),
            ...options.map((opt) {
              return RadioListTile<int>(
                title: Text(opt.$2),
                value: opt.$1,
                groupValue: settings.autoDeleteHari,
                onChanged: (v) => Navigator.of(ctx).pop(v),
              );
            }),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Batal')),
        ],
      ),
    );
    if (selected != null) {
      await settings.setAutoDeleteHari(selected);
      notifier.bump();
    }
  }

  static Future<void> _showWatermarkSheet(
      BuildContext context, SettingsService settings, SettingsRevisionNotifier notifier) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Watermark', style: Theme.of(ctx).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Aktifkan Watermark'),
                      value: settings.watermarkEnabled,
                      onChanged: (v) async {
                        await settings.setWatermarkEnabled(v);
                        setSheetState(() {});
                        notifier.bump();
                      },
                    ),
                    const Divider(),
                    Text('Isi Watermark', style: Theme.of(ctx).textTheme.labelLarge),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Tanggal'),
                      value: settings.watermarkTanggal,
                      onChanged: settings.watermarkEnabled
                          ? (v) async {
                              await settings.setWatermarkTanggal(v ?? false);
                              setSheetState(() {});
                              notifier.bump();
                            }
                          : null,
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Jam'),
                      value: settings.watermarkJam,
                      onChanged: settings.watermarkEnabled
                          ? (v) async {
                              await settings.setWatermarkJam(v ?? false);
                              setSheetState(() {});
                              notifier.bump();
                            }
                          : null,
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Latitude'),
                      value: settings.watermarkLatitude,
                      onChanged: settings.watermarkEnabled
                          ? (v) async {
                              await settings.setWatermarkLatitude(v ?? false);
                              setSheetState(() {});
                              notifier.bump();
                            }
                          : null,
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Longitude'),
                      value: settings.watermarkLongitude,
                      onChanged: settings.watermarkEnabled
                          ? (v) async {
                              await settings.setWatermarkLongitude(v ?? false);
                              setSheetState(() {});
                              notifier.bump();
                            }
                          : null,
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Nama Jalan (opsional)'),
                      value: settings.watermarkNamaJalan,
                      onChanged: settings.watermarkEnabled
                          ? (v) async {
                              await settings.setWatermarkNamaJalan(v ?? false);
                              setSheetState(() {});
                              notifier.bump();
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.title, this.tiles);
  final String title;
  final List<Widget> tiles;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
        child: Text(title, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
      ),
      ...tiles,
    ]);
  }
}

class _Tile extends StatelessWidget {
  const _Tile(this.icon, this.label, {this.subtitle, this.trailing, this.onTap});
  final IconData icon;
  final String label;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => ListTile(
        leading: Icon(icon),
        title: Text(label),
        subtitle: subtitle != null ? Text(subtitle!) : null,
        trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
        onTap: onTap,
      );
}
