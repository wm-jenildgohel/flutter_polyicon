import 'dart:io';
import 'package:yaml/yaml.dart';

class Config {
  final String name;
  final String fontFilePath;
  final String dartFilePath;
  final String svgDir;

  Config({
    required this.name,
    required this.fontFilePath,
    required this.dartFilePath,
    required this.svgDir,
  });

  static Future<Config> fromFile(String path) async {
    final file = File(path);
    if (!await file.exists()) {
      throw Exception('Configuration file not found: $path');
    }

    final content = await file.readAsString();
    final yaml = loadYaml(content);

    return Config(
      name: yaml['name'] ?? 'MyAppIcons',
      fontFilePath: yaml['output']?['font_file'] ?? 'lib/fonts/app_icons.ttf',
      dartFilePath: yaml['output']?['dart_file'] ?? 'lib/icons/app_icons.dart',
      svgDir: yaml['input']?['svg_dir'] ?? 'assets/icons/svg',
    );
  }
}
