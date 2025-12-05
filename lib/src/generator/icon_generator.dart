import 'dart:typed_data';
import 'package:icon_font_generator/icon_font_generator.dart';
import 'package:path/path.dart' as path;
import '../config/config.dart';
import '../utils/logger.dart';
import '../utils/exceptions.dart';
import 'svg_loader.dart';
import 'output_writer.dart';

class IconGenerator {
  final Config config;
  final Logger logger;
  final bool recursive;

  IconGenerator({
    required this.config,
    required this.logger,
    this.recursive = false,
  });

  Future<void> generate() async {
    final stopwatch = Stopwatch()..start();

    try {
      logger.step('📁 Scanning for SVG files in ${config.svgDir}');
      final svgMap = await _loadSvgFiles();

      if (svgMap.isEmpty) {
        throw GenerationException(
          'No SVG files found in ${config.svgDir}\n'
          '${recursive ? '' : 'Tip: Use --recursive to scan subdirectories'}',
        );
      }

      logger.success('Found ${svgMap.length} SVG file${svgMap.length == 1 ? '' : 's'}');

      logger.step('⚙️  Converting SVGs to font...');
      final result = await _convertToFont(svgMap);

      logger.step('💾 Writing font file...');
      await _writeFontFile(result.font);

      logger.step('📝 Generating Flutter class...');
      await _generateDartClass(result);

      stopwatch.stop();

      print(OutputWriter(logger).generateSummary(
        iconCount: svgMap.length,
        fontPath: config.fontFilePath,
        dartPath: config.dartFilePath,
        elapsed: stopwatch.elapsed,
      ));
    } catch (e) {
      if (e is GenerationException || e is ValidationException) {
        rethrow;
      }
      throw GenerationException('Icon generation failed', e);
    }
  }

  Future<Map<String, String>> _loadSvgFiles() async {
    final loader = SvgLoader(logger);
    return await loader.loadSvgFiles(
      directory: config.svgDir,
      recursive: recursive,
    );
  }

  Future<SvgToOtfResult> _convertToFont(Map<String, String> svgMap) async {
    try {
      return svgToOtf(
        svgMap: svgMap,
        fontName: config.name,
        normalize: true,
        ignoreShapes: true,
      );
    } catch (e) {
      throw GenerationException(
        'Failed to convert SVGs to font. Ensure all SVG files are valid',
        e,
      );
    }
  }

  Future<void> _writeFontFile(OpenTypeFont font) async {
    try {
      final fontBytes = _encodeFontToBytes(font);
      final writer = OutputWriter(logger);
      await writer.writeFontFile(config.fontFilePath, fontBytes);
    } catch (e) {
      throw GenerationException('Failed to write font file', e);
    }
  }

  List<int> _encodeFontToBytes(OpenTypeFont font) {
    final byteData = ByteData(font.size);
    font.encodeToBinary(byteData);
    return byteData.buffer.asUint8List();
  }

  Future<void> _generateDartClass(SvgToOtfResult result) async {
    try {
      final className = _deriveClassName();
      final fontFileName = path.basename(config.fontFilePath);

      final dartCode = generateFlutterClass(
        glyphList: result.glyphList,
        className: className,
        familyName: config.name,
        fontFileName: fontFileName,
        indent: 2,
      );

      final writer = OutputWriter(logger);
      await writer.writeDartFile(config.dartFilePath, dartCode);
    } catch (e) {
      throw GenerationException('Failed to generate Dart class', e);
    }
  }

  String _deriveClassName() {
    if (config.className != null && config.className!.isNotEmpty) {
      return config.className!;
    }

    // If the name is already PascalCase (no underscores), return it as is
    if (!config.name.contains('_')) {
      return config.name;
    }

    final parts = config.name.split('_');
    return parts
        .map((part) => part.isEmpty
            ? ''
            : part[0].toUpperCase() + part.substring(1).toLowerCase())
        .join();
  }
}
