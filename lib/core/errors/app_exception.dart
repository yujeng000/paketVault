sealed class AppException implements Exception {
  const AppException(this.message);
  final String message;
  @override
  String toString() => message;
}

final class CameraException extends AppException {
  const CameraException(super.message);
}

final class LocationException extends AppException {
  const LocationException(super.message);
}

final class PermissionException extends AppException {
  const PermissionException(super.message);
}

final class DatabaseException extends AppException {
  const DatabaseException(super.message);
}

final class ScannerException extends AppException {
  const ScannerException(super.message);
}

final class PhotoException extends AppException {
  const PhotoException(super.message);
}

/// Exception untuk operasi cloud sync (Milestone 3).
final class SyncException extends AppException {
  const SyncException(super.message);
}
