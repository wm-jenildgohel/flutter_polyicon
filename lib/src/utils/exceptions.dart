class ConfigException implements Exception {
  final String message;
  ConfigException(this.message);

  @override
  String toString() => message;
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);

  @override
  String toString() => message;
}

class GenerationException implements Exception {
  final String message;
  final dynamic cause;

  GenerationException(this.message, [this.cause]);

  @override
  String toString() => cause != null ? '$message: $cause' : message;
}

class FileSystemException implements Exception {
  final String message;
  final String? path;

  FileSystemException(this.message, [this.path]);

  @override
  String toString() => path != null ? '$message: $path' : message;
}
