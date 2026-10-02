import 'package:connectivity_plus/connectivity_plus.dart';

/// Service untuk cek dan monitor status koneksi internet.
/// Menggunakan connectivity_plus 6.x API:
/// - checkConnectivity() → List<ConnectivityResult>
/// - onConnectivityChanged → Stream<List<ConnectivityResult>>
class ConnectivityService {
  ConnectivityService();

  final Connectivity _connectivity = Connectivity();

  /// Cek koneksi internet saat ini.
  /// Mengembalikan true jika ada koneksi aktif (wifi, mobile, ethernet).
  Future<bool> isConnected() async {
    final results = await _connectivity.checkConnectivity();
    return _hasConnection(results);
  }

  /// Stream perubahan koneksi — emit true saat ada internet, false saat tidak.
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map(_hasConnection);
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.any((r) =>
        r == ConnectivityResult.mobile ||
        r == ConnectivityResult.wifi ||
        r == ConnectivityResult.ethernet);
  }
}
