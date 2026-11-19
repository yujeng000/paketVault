import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paketvault/core/utils/uuid_util.dart';
import 'package:paketvault/core/constants/photo_type.dart';
import 'package:paketvault/core/constants/sync_status.dart';
import 'package:paketvault/core/errors/app_exception.dart';
import 'package:paketvault/core/routing/app_routes.dart';
import 'package:paketvault/core/services/location_service.dart';
import 'package:paketvault/core/utils/date_formatter.dart';
import 'package:paketvault/features/delivery/data/models/delivery_evidence.dart';
import 'package:paketvault/features/delivery/data/models/delivery_photo.dart';
import 'package:paketvault/features/delivery/providers/delivery_providers.dart';
import 'package:paketvault/features/form_bukti/presentation/widgets/photo_picker_section.dart';
import 'package:paketvault/features/form_bukti/presentation/widgets/success_popup.dart';
import 'package:paketvault/features/pengaturan/providers/pengaturan_providers.dart';
import 'package:paketvault/features/sync/providers/sync_providers.dart';

/// Penanda otomatis untuk bukti tanpa nomor resi, mis. TANPA-RESI-20261117-141530.
String _resiOtomatis(DateTime t) {
  String d(int v, [int n = 2]) => v.toString().padLeft(n, '0');
  return 'TANPA-RESI-${d(t.year, 4)}${d(t.month)}${d(t.day)}-${d(t.hour)}${d(t.minute)}${d(t.second)}';
}

// ── State ─────────────────────────────────────────────────────────────────────

class _FormState {
  const _FormState({
    this.resi = '', this.namaPemilik = '', this.nomorHp = '',
    this.fotoPaketPath, this.fotoRumahPath, this.fotoPenerimaPath,
    this.latitude, this.longitude, this.gpsAkurasi,
    this.isSaving = false, this.isLoadingGps = false, this.errorMessage,
  });

  final String resi, namaPemilik, nomorHp;
  final String? fotoPaketPath, fotoRumahPath, fotoPenerimaPath;
  final double? latitude, longitude, gpsAkurasi;
  final bool isSaving, isLoadingGps;
  final String? errorMessage;

  bool get hasGps => latitude != null && longitude != null;
  bool get canSave => fotoPaketPath != null; // resi opsional

  _FormState copyWith({
    String? resi, String? namaPemilik, String? nomorHp,
    String? fotoPaketPath, String? fotoRumahPath, String? fotoPenerimaPath,
    double? latitude, double? longitude, double? gpsAkurasi,
    bool? isSaving, bool? isLoadingGps, String? errorMessage, bool clearError = false,
  }) {
    return _FormState(
      resi: resi ?? this.resi,
      namaPemilik: namaPemilik ?? this.namaPemilik,
      nomorHp: nomorHp ?? this.nomorHp,
      fotoPaketPath: fotoPaketPath ?? this.fotoPaketPath,
      fotoRumahPath: fotoRumahPath ?? this.fotoRumahPath,
      fotoPenerimaPath: fotoPenerimaPath ?? this.fotoPenerimaPath,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      gpsAkurasi: gpsAkurasi ?? this.gpsAkurasi,
      isSaving: isSaving ?? this.isSaving,
      isLoadingGps: isLoadingGps ?? this.isLoadingGps,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

// ── Notifier ──────────────────────────────────────────────────────────────────

class _FormBuktiNotifier extends Notifier<_FormState> {
  @override
  _FormState build() => const _FormState();

  void setResi(String v) => state = state.copyWith(resi: v);
  void setNamaPemilik(String v) => state = state.copyWith(namaPemilik: v);
  void setNomorHp(String v) => state = state.copyWith(nomorHp: v);
  void setFotoPaket(String p) => state = state.copyWith(fotoPaketPath: p);
  void setFotoRumah(String p) => state = state.copyWith(fotoRumahPath: p);
  void setFotoPenerima(String p) => state = state.copyWith(fotoPenerimaPath: p);

  Future<void> loadGps() async {
    state = state.copyWith(isLoadingGps: true, clearError: true);
    try {
      final loc = await const LocationService().getCurrentLocation();
      state = state.copyWith(
        latitude: loc.latitude, longitude: loc.longitude,
        gpsAkurasi: loc.accuracy, isLoadingGps: false,
      );
    } on LocationException catch (e) {
      state = state.copyWith(isLoadingGps: false, errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(isLoadingGps: false, errorMessage: 'Gagal GPS: $e');
    }
  }

  Future<int?> save() async {
    if (!state.canSave) return null;
    state = state.copyWith(isSaving: true, clearError: true);
    try {
      final now = DateTime.now();
      final repo = ref.read(deliveryRepositoryProvider);
      // Resi opsional: bila kosong, buat penanda unik dari waktu (resi harus unik di database).
      final resi = state.resi.trim().isEmpty ? _resiOtomatis(now) : state.resi.trim();
      final evidence = DeliveryEvidence()
        ..uuid = generateUuid()
        ..resi = resi
        ..namaPemilik = state.namaPemilik.trim().isEmpty ? null : state.namaPemilik.trim()
        ..nomorHp = state.nomorHp.trim().isEmpty ? null : state.nomorHp.trim()
        ..latitude = state.latitude
        ..longitude = state.longitude
        ..gpsAkurasi = state.gpsAkurasi
        ..waktu = now
        ..syncStatusValue = SyncStatus.pending.value;

      final evidenceId = await repo.saveEvidence(evidence);

      for (final (path, type) in <(String?, PhotoType)>[
        (state.fotoPaketPath, PhotoType.paket),
        (state.fotoRumahPath, PhotoType.rumah),
        (state.fotoPenerimaPath, PhotoType.penerima),
      ]) {
        if (path == null) continue;
        final photo = DeliveryPhoto()
          ..uuid = generateUuid()
          ..evidenceUuid = evidence.uuid
          ..evidenceId = evidenceId
          ..evidenceResi = resi
          ..localPath = path
          ..photoTypeValue = type.value
          ..createdAt = now;
        await repo.savePhoto(photo);
      }

      ref.invalidate(allEvidencesProvider);
      ref.invalidate(pendingSyncCountProvider);
      state = state.copyWith(isSaving: false);
      return evidenceId;
    } catch (e) {
      state = state.copyWith(isSaving: false, errorMessage: 'Gagal menyimpan: $e');
      return null;
    }
  }

  void reset() => state = const _FormState();
}

final _formBuktiProvider =
    NotifierProvider<_FormBuktiNotifier, _FormState>(_FormBuktiNotifier.new);

// ── Page ──────────────────────────────────────────────────────────────────────

class FormBuktiPage extends ConsumerStatefulWidget {
  const FormBuktiPage({super.key, this.resi = ''});
  final String resi;

  @override
  ConsumerState<FormBuktiPage> createState() => _FormBuktiPageState();
}

class _FormBuktiPageState extends ConsumerState<FormBuktiPage> {
  final _resiCtrl = TextEditingController();
  final _namaPemilikCtrl = TextEditingController();
  final _nomorHpCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(_formBuktiProvider.notifier).reset();
      if (widget.resi.isNotEmpty) {
        _resiCtrl.text = widget.resi;
        ref.read(_formBuktiProvider.notifier).setResi(widget.resi);
      }
      // Milestone 4: hanya auto-load GPS jika "GPS Otomatis" aktif di Pengaturan.
      if (ref.read(settingsServiceProvider).gpsOtomatis) {
        ref.read(_formBuktiProvider.notifier).loadGps();
      }
    });
  }

  @override
  void dispose() {
    _resiCtrl.dispose(); _namaPemilikCtrl.dispose(); _nomorHpCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    FocusScope.of(context).unfocus();
    final evidenceId = await ref.read(_formBuktiProvider.notifier).save();
    if (!mounted) return;
    if (evidenceId != null) {
      await showSuccessPopup(context);
      if (!mounted) return;

      // Trigger sync di background (fire and forget)
      _triggerSyncInBackground(evidenceId);

      context.goNamed(AppRoutes.homeName);
    }
  }

  void _triggerSyncInBackground(int evidenceId) {
    final isConfigured = ref.read(isSupabaseConfiguredProvider);
    if (!isConfigured) return;
    // Milestone 4: hormati setting "Upload Otomatis" di Pengaturan.
    if (!ref.read(settingsServiceProvider).uploadOtomatis) return;
    ref.read(syncServiceProvider).syncById(evidenceId).then((_) {
      if (mounted) {
        ref.invalidate(allEvidencesProvider);
        ref.invalidate(pendingSyncCountProvider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(_formBuktiProvider);
    final n = ref.read(_formBuktiProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Bukti'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.goNamed(AppRoutes.homeName)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (formState.errorMessage != null)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: theme.colorScheme.errorContainer, borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  Icon(Icons.error_outline, color: theme.colorScheme.onErrorContainer),
                  const SizedBox(width: 8),
                  Expanded(child: Text(formState.errorMessage!, style: TextStyle(color: theme.colorScheme.onErrorContainer))),
                ]),
              ),

            _Label('Nomor Resi'),
            TextField(controller: _resiCtrl, textCapitalization: TextCapitalization.characters,
                onChanged: n.setResi, decoration: const InputDecoration(hintText: 'Opsional (kosong = dibuat otomatis)', prefixIcon: Icon(Icons.qr_code))),
            const SizedBox(height: 20),

            _InfoRow(icon: Icons.access_time_outlined, label: 'Waktu', value: DateFormatter.tanggalJam(DateTime.now())),
            const SizedBox(height: 8),
            _GpsRow(formState: formState, onRetry: n.loadGps),
            const SizedBox(height: 20),

            _Label('Nama Pemilik Paket'),
            TextField(controller: _namaPemilikCtrl, onChanged: n.setNamaPemilik, decoration: const InputDecoration(hintText: 'Opsional')),
            const SizedBox(height: 12),

            _Label('Nomor HP'),
            TextField(controller: _nomorHpCtrl, keyboardType: TextInputType.phone, onChanged: n.setNomorHp, decoration: const InputDecoration(hintText: 'Opsional')),
            const SizedBox(height: 24),

            Text('Foto', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            PhotoPickerSection(photoType: PhotoType.paket, resi: formState.resi.isEmpty ? 'resi' : formState.resi, imagePath: formState.fotoPaketPath, onPhotoTaken: n.setFotoPaket),
            const SizedBox(height: 16),
            PhotoPickerSection(photoType: PhotoType.rumah, resi: formState.resi.isEmpty ? 'resi' : formState.resi, imagePath: formState.fotoRumahPath, onPhotoTaken: n.setFotoRumah),
            const SizedBox(height: 16),
            PhotoPickerSection(photoType: PhotoType.penerima, resi: formState.resi.isEmpty ? 'resi' : formState.resi, imagePath: formState.fotoPenerimaPath, onPhotoTaken: n.setFotoPenerima),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (!formState.canSave || formState.isSaving) ? null : _handleSave,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16),
                    disabledBackgroundColor: theme.colorScheme.outline.withValues(alpha: 0.3)),
                child: formState.isSaving
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text('Simpan Bukti', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),

            if (!formState.canSave)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Foto paket wajib diambil',
                  style: TextStyle(color: theme.colorScheme.error, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text, {this.required = false});
  final String text;
  final bool required;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(children: [
        Text(text, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600)),
        if (required) ...[const SizedBox(width: 4), Text('*', style: TextStyle(color: Theme.of(context).colorScheme.error))],
      ]),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        Icon(icon, size: 18, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary)),
        const Spacer(),
        Text(value, style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500)),
      ]),
    );
  }
}

class _GpsRow extends StatelessWidget {
  const _GpsRow({required this.formState, required this.onRetry});
  final _FormState formState;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (formState.isLoadingGps) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
          const SizedBox(width: 8),
          Text('Mengambil lokasi GPS...', style: theme.textTheme.bodySmall),
        ]),
      );
    }
    if (formState.hasGps) {
      return _InfoRow(
        icon: Icons.gps_fixed, label: 'GPS',
        value: '${formState.latitude!.toStringAsFixed(5)}, ${formState.longitude!.toStringAsFixed(5)} (±${formState.gpsAkurasi!.toStringAsFixed(0)}m)',
      );
    }
    return GestureDetector(
      onTap: onRetry,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(color: theme.colorScheme.errorContainer.withValues(alpha: 0.4), borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          Icon(Icons.gps_off, size: 18, color: theme.colorScheme.error),
          const SizedBox(width: 8),
          Expanded(child: Text('GPS tidak tersedia. Ketuk untuk coba lagi.', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error))),
          Icon(Icons.refresh, size: 16, color: theme.colorScheme.error),
        ]),
      ),
    );
  }
}
