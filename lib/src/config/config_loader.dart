import 'dart:io';
import 'package:yaml/yaml.dart';
import '../utils/exceptions.dart';
import 'config.dart';

class ConfigLoader {
  static Future<Config> load(String configPath) async {
    final file = File(configPath);

    if (!await file.exists()) {
      throw ConfigException(
        'Configuration file not found: $configPath\n\n'
        'Run "flutter_polyicon init" to create a configuration file, or\n'
        'specify a custom config path with --config',
      );
    }

    String content;
    try {
      content = await file.readAsString();
    } catch (e) {
      throw ConfigException('Failed to read configuration file: $e');
    }

    YamlMap yaml;
    try {
      yaml = loadYaml(content) as YamlMap;
    } catch (e) {
      throw ConfigException(
        'Invalid YAML in configuration file:\n$e\n\n'
        'Please check the syntax of your flutter_polyicon.yaml file',
      );
    }

    try {
      return Config(
        name: _getString(yaml, 'name', required: true)!,
        fontFilePath: _getString(
          yaml['output'] as YamlMap?,
          'font_file',
          required: true,
        )!,
        dartFilePath: _getString(
          yaml['output'] as YamlMap?,
          'dart_file',
          required: true,
        )!,
        svgDir: _getString(
          yaml['input'] as YamlMap?,
          'svg_dir',
          required: true,
        )!,
      );
    } catch (e) {
      throw ConfigException('Error parsing configuration: $e');
    }
  }

  static String? _getString(
    YamlMap? map,
    String key, {
    bool required = false,
    String? defaultValue,
  }) {
    if (map == null) {
      if (required) {
        throw ConfigException('Missing required configuration section');
      }
      return defaultValue;
    }

    final value = map[key];

    if (value == null) {
      if (required) {
        throw ConfigException('Missing required configuration field: $key');
      }
      return defaultValue;
    }

    if (value is! String) {
      throw ConfigException('Configuration field "$key" must be a string');
    }

    return value;
  }
}
