import 'dart:io';
import 'package:flutter/material.dart';
import 'package:paketvault/core/constants/photo_type.dart';
import 'package:paketvault/core/theme/app_colors.dart';
import 'package:paketvault/features/form_bukti/presentation/pages/camera_capture_page.dart';

class PhotoPickerSection extends StatelessWidget {
  const PhotoPickerSection({
    super.key,
    required this.photoType,
    required this.resi,
    required this.imagePath,
    required this.onPhotoTaken,
  });

  final PhotoType photoType;
  final String resi;
  final String? imagePath;
  final ValueChanged<String> onPhotoTaken;

  Future<void> _openCamera(BuildContext context) async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => CameraCapturePage(title: photoType.label, resi: resi, suffix: photoType.name),
        fullscreenDialog: true,
      ),
    );
    if (result != null) onPhotoTaken(result);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasPhoto = imagePath != null && imagePath!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.photo_camera_outlined, size: 18),
            const SizedBox(width: 6),
            Text(photoType.label, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600)),
            if (photoType == PhotoType.paket) ...[
              const SizedBox(width: 4),
              Text('(Wajib)', style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.error)),
            ],
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _openCamera(context),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: hasPhoto ? AppColors.statusSynced : theme.colorScheme.outline.withValues(alpha: 0.4),
                width: hasPhoto ? 2 : 1,
              ),
              color: hasPhoto ? Colors.transparent : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            ),
            clipBehavior: Clip.antiAlias,
            child: hasPhoto
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(File(imagePath!), fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Center(
                              child: Icon(Icons.broken_image_outlined, color: Colors.grey, size: 40))),
                      Positioned(bottom: 8, right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.65), borderRadius: BorderRadius.circular(20)),
                          child: const Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.camera_alt, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text('Ganti', style: TextStyle(color: Colors.white, fontSize: 12)),
                          ]),
                        )),
                      Positioned(top: 8, right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: AppColors.statusSynced, shape: BoxShape.circle),
                          child: const Icon(Icons.check, color: Colors.white, size: 14),
                        )),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo_outlined, size: 36, color: theme.colorScheme.primary),
                      const SizedBox(height: 8),
                      Text('Ketuk untuk mengambil foto',
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline)),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
