import 'package:path/path.dart' as path;
import '../utils/file_utils.dart';
import '../utils/logger.dart';

class OutputWriter {
  final Logger logger;

  OutputWriter(this.logger);

  Future<void> writeFontFile(String filePath, List<int> fontBytes) async {
    logger.detail('Writing font file to $filePath');
    await FileUtils.writeBinaryFile(filePath, fontBytes);
    logger.success('Font generated: $filePath');
  }

  Future<void> writeDartFile(String filePath, String content) async {
    logger.detail('Writing Dart class to $filePath');
    await FileUtils.writeFileWithBackup(filePath, content);
    logger.success('Dart class generated: $filePath');
  }

  String generateSummary({
    required int iconCount,
    required String fontPath,
    required String dartPath,
    required Duration elapsed,
  }) {
    final className = _getClassNameFromPath(dartPath);

    return '''

✨ Generation complete in ${elapsed.inMilliseconds / 1000}s

Generated $iconCount icons:
  - Font: $fontPath
  - Class: $dartPath

Next steps:
  1. Add font to pubspec.yaml:
     flutter:
       fonts:
         - family: AppIcons
           fonts:
             - asset: $fontPath

  2. Import and use:
     import 'package:your_app/${dartPath.replaceAll('lib/', '')}';
     Icon($className.iconName)
''';
  }

  String _getClassNameFromPath(String dartPath) {
    final baseName = path.basenameWithoutExtension(dartPath);
    final parts = baseName.split('_');
    return parts.map((p) => p[0].toUpperCase() + p.substring(1)).join();
  }
}
