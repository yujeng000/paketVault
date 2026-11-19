import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paketvault/core/routing/app_routes.dart';
import 'package:paketvault/features/form_bukti/presentation/pages/form_bukti_page.dart';
import 'package:paketvault/features/home/presentation/pages/home_page.dart';
import 'package:paketvault/features/pengaturan/presentation/pages/pengaturan_page.dart';
import 'package:paketvault/features/riwayat/presentation/pages/riwayat_detail_page.dart';
import 'package:paketvault/features/riwayat/presentation/pages/riwayat_page.dart';
import 'package:paketvault/features/riwayat_gambar/presentation/pages/riwayat_gambar_page.dart';
import 'package:paketvault/features/scanner/presentation/pages/scanner_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: kDebugMode,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.homeName,
        builder: (_, _) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.scanner,
        name: AppRoutes.scannerName,
        builder: (_, _) => const ScannerPage(),
      ),
      GoRoute(
        path: AppRoutes.formBukti,
        name: AppRoutes.formBuktiName,
        builder: (_, state) {
          final resi = state.uri.queryParameters[AppRoutes.paramResi] ?? '';
          return FormBuktiPage(resi: resi);
        },
      ),
      GoRoute(
        path: AppRoutes.riwayat,
        name: AppRoutes.riwayatName,
        builder: (_, _) => const RiwayatPage(),
        routes: [
          GoRoute(
            path: AppRoutes.riwayatDetailSegment,
            name: AppRoutes.riwayatDetailName,
            builder: (_, state) =>
                RiwayatDetailPage(id: state.pathParameters['id'] ?? ''),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.riwayatGambar,
        name: AppRoutes.riwayatGambarName,
        builder: (_, _) => const RiwayatGambarPage(),
      ),
      GoRoute(
        path: AppRoutes.pengaturan,
        name: AppRoutes.pengaturanName,
        builder: (_, _) => const PengaturanPage(),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
