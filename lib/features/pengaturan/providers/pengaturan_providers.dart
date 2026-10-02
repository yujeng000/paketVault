import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paketvault/core/services/settings_service.dart';

/// Di-override di main.dart setelah SharedPreferences.getInstance() selesai.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
      'sharedPreferencesProvider harus di-override di main.dart sebelum runApp.');
});

final settingsServiceProvider = Provider<SettingsService>((ref) {
  return SettingsService(ref.watch(sharedPreferencesProvider));
});

/// SettingsService bersifat sinkron (bukan Stream/Future), jadi kita perlu
/// notifier kosong ini hanya untuk memicu rebuild widget Settings setelah
/// sebuah nilai diubah (mis. setelah user pilih opsi di dialog).
class SettingsRevisionNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void bump() => state = state + 1;
}

final settingsRevisionProvider =
    NotifierProvider<SettingsRevisionNotifier, int>(SettingsRevisionNotifier.new);
