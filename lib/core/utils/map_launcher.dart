import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Membuka aplikasi peta (Google Maps) langsung ke rute menuju koordinat tujuan.
class MapLauncher {
  const MapLauncher._();

  static Future<void> navigateTo(BuildContext context, double lat, double lng) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving',
    );
    var ok = false;
    try {
      ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak bisa membuka aplikasi peta')),
      );
    }
  }
}
