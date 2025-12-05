import 'dart:io';
import 'package:path/path.dart' as path;
import 'exceptions.dart';

class FileUtils {
  static Future<void> ensureDirectoryExists(String filePath) async {
    final dir = Directory(path.dirname(filePath));
    if (!await dir.exists()) {
      try {
        await dir.create(recursive: true);
      } catch (e) {
        throw FileSystemException(
          'Failed to create directory',
          dir.path,
        );
      }
    }
  }

  static Future<void> writeFileWithBackup(
      String filePath, String content) async {
    await ensureDirectoryExists(filePath);

    final file = File(filePath);

    if (await file.exists()) {
      final backupPath = '$filePath.backup';
      await file.copy(backupPath);
    }

    try {
      await file.writeAsString(content);
    } catch (e) {
      throw FileSystemException(
        'Failed to write file',
        filePath,
      );
    }
  }

  static Future<void> writeBinaryFile(String filePath, List<int> bytes) async {
    await ensureDirectoryExists(filePath);

    final file = File(filePath);
    try {
      await file.writeAsBytes(bytes);
    } catch (e) {
      throw FileSystemException(
        'Failed to write binary file',
        filePath,
      );
    }
  }

  static bool isValidPath(String filePath) {
    try {
      path.normalize(filePath);
      return true;
    } catch (_) {
      return false;
    }
  }

  static String normalizePath(String filePath) {
    return path.normalize(filePath);
  }

  static Future<bool> isDirectoryWritable(String dirPath) async {
    final dir = Directory(dirPath);
    if (!await dir.exists()) {
      return false;
    }

    final testFile = File(path.join(
        dirPath, '.write_test_${DateTime.now().millisecondsSinceEpoch}'));
    try {
      await testFile.writeAsString('test');
      await testFile.delete();
      return true;
    } catch (_) {
      return false;
    }
  }
}
