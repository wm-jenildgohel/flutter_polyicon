import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:xml/xml.dart';
import '../utils/exceptions.dart';
import '../utils/logger.dart';

class SvgLoader {
  final Logger logger;

  SvgLoader(this.logger);

  Future<Map<String, String>> loadSvgFiles({
    required String directory,
    bool recursive = false,
  }) async {
    final dir = Directory(directory);
    final svgMap = <String, String>{};
    final duplicates = <String>[];

    await for (final entity in dir.list(recursive: recursive)) {
      if (entity is File && entity.path.toLowerCase().endsWith('.svg')) {
        final filename = path.basenameWithoutExtension(entity.path);

        if (svgMap.containsKey(filename)) {
          duplicates.add(filename);
          continue;
        }

        try {
          final content = await entity.readAsString();
          _validateSvg(filename, content);
          svgMap[filename] = content;
          logger.detail('Loaded: $filename.svg');
        } catch (e) {
          logger.warning('Skipping invalid SVG: $filename.svg ($e)');
        }
      }
    }

    if (duplicates.isNotEmpty) {
      logger.warning(
        'Found duplicate filenames (using first occurrence): ${duplicates.join(", ")}',
      );
    }

    return svgMap;
  }

  void _validateSvg(String filename, String content) {
    try {
      final document = XmlDocument.parse(content);
      final root = document.rootElement;

      if (root.name.local.toLowerCase() != 'svg') {
        throw ValidationException('Root element is not <svg>');
      }

      final hasContent = root.children.any((node) =>
          node is XmlElement &&
          (node.name.local == 'path' ||
              node.name.local == 'rect' ||
              node.name.local == 'circle' ||
              node.name.local == 'polygon' ||
              node.name.local == 'polyline' ||
              node.name.local == 'ellipse' ||
              node.name.local == 'line' ||
              node.name.local == 'g'));

      if (!hasContent) {
        logger.warning('SVG "$filename" appears to be empty or has no drawable content');
      }
    } catch (e) {
      throw ValidationException('Invalid SVG XML: $e');
    }
  }

  static String sanitizeIconName(String filename) {
    var name = filename
        .replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_')
        .replaceAll(RegExp(r'__+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');

    if (name.isEmpty) {
      name = 'icon';
    }

    if (RegExp(r'^\d').hasMatch(name)) {
      name = 'icon_$name';
    }

    return name;
  }
}
