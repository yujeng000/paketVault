import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:paketvault/core/errors/app_exception.dart';

abstract final class FileUtils {
  FileUtils._();

  static Future<Directory> _photosDir() async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(base.path, 'paketvault_photos'));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  static Future<String> savePhoto({
    required String sourcePath,
    required String resi,
    required String suffix,
  }) async {
    try {
      final dir = await _photosDir();
      final ts = DateTime.now().millisecondsSinceEpoch;
      final fileName = '${resi}_${suffix}_$ts.jpg';
      final targetPath = p.join(dir.path, fileName);

      final Uint8List? compressed = await FlutterImageCompress.compressWithFile(
        sourcePath,
        quality: 80,
        minWidth: 1280,
        minHeight: 960,
        format: CompressFormat.jpeg,
      );

      if (compressed == null) throw const PhotoException('Gagal mengompresi foto.');
      await File(targetPath).writeAsBytes(compressed);
      return targetPath;
    } catch (e) {
      if (e is PhotoException) rethrow;
      throw PhotoException('Gagal menyimpan foto: $e');
    }
  }

  static Future<void> deletePhoto(String localPath) async {
    try {
      final file = File(localPath);
      if (await file.exists()) await file.delete();
    } catch (_) {}
  }

  static Future<bool> exists(String localPath) async {
    return File(localPath).exists();
  }
}
