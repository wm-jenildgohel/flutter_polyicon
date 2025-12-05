import 'dart:io';
import 'package:path/path.dart' as path;
import '../utils/exceptions.dart';
import 'config.dart';

class ConfigValidator {
  static Future<void> validate(Config config) async {
    _validateName(config.name);
    await _validateSvgDirectory(config.svgDir);
    _validateOutputPaths(config.fontFilePath, config.dartFilePath);
  }

  static void _validateName(String name) {
    if (name.isEmpty) {
      throw ValidationException('Icon set name cannot be empty');
    }

    if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$').hasMatch(name)) {
      throw ValidationException(
        'Icon set name must start with a letter and contain only letters, numbers, and underscores',
      );
    }
  }

  static Future<void> _validateSvgDirectory(String svgDir) async {
    final dir = Directory(svgDir);

    if (!await dir.exists()) {
      throw ValidationException(
        'SVG directory does not exist: $svgDir\n'
        'Please create the directory and add SVG files, or update the path in flutter_polyicon.yaml',
      );
    }

    if (!await dir.stat().then((stat) => stat.type == FileSystemEntityType.directory)) {
      throw ValidationException('SVG path is not a directory: $svgDir');
    }

    final svgFiles = await dir
        .list()
        .where((entity) => entity is File && entity.path.toLowerCase().endsWith('.svg'))
        .toList();

    if (svgFiles.isEmpty) {
      throw ValidationException(
        'No SVG files found in: $svgDir\n'
        'Add .svg files to this directory or enable recursive scanning with --recursive',
      );
    }
  }

  static void _validateOutputPaths(String fontFilePath, String dartFilePath) {
    if (fontFilePath.isEmpty) {
      throw ValidationException('Font output path cannot be empty');
    }

    if (dartFilePath.isEmpty) {
      throw ValidationException('Dart output path cannot be empty');
    }

    final fontExt = path.extension(fontFilePath).toLowerCase();
    if (fontExt != '.ttf' && fontExt != '.otf') {
      throw ValidationException(
        'Font file must have .ttf or .otf extension, got: $fontExt',
      );
    }

    final dartExt = path.extension(dartFilePath).toLowerCase();
    if (dartExt != '.dart') {
      throw ValidationException(
        'Dart file must have .dart extension, got: $dartExt',
      );
    }

    final fontDir = path.dirname(fontFilePath);
    if (!Directory(fontDir).existsSync() && !_canCreateDirectory(fontDir)) {
      throw ValidationException(
        'Cannot create font output directory: $fontDir',
      );
    }

    final dartDir = path.dirname(dartFilePath);
    if (!Directory(dartDir).existsSync() && !_canCreateDirectory(dartDir)) {
      throw ValidationException(
        'Cannot create Dart output directory: $dartDir',
      );
    }
  }

  static bool _canCreateDirectory(String dirPath) {
    try {
      final parent = Directory(path.dirname(dirPath));
      return parent.existsSync();
    } catch (_) {
      return false;
    }
  }
}
