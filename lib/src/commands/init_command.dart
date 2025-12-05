import 'dart:io';
import 'package:args/command_runner.dart';

class InitCommand extends Command {
  @override
  final String name = 'init';

  @override
  final String description =
      'Initialize the flutter_polyicon configuration file.';

  InitCommand() {
    argParser.addFlag(
      'force',
      abbr: 'f',
      help: 'Overwrite existing configuration file.',
      negatable: false,
    );
  }

  @override
  Future<void> run() async {
    final force = argResults!['force'] as bool;
    final configFile = File('flutter_polyicon.yaml');

    if (await configFile.exists() && !force) {
      print('✓ flutter_polyicon.yaml already exists.');
      print('  Use --force to overwrite.');
      return;
    }

    final content = '''# Flutter Polyicon Configuration
# Generated icon font settings

# Name of the icon set and generated class
name: MyAppIcons

# Output paths for generated files
output:
  # Font file location (.ttf or .otf)
  font_file: lib/fonts/app_icons.ttf
  # Dart class file location
  dart_file: lib/icons/app_icons.dart

# Input configuration
input:
  # Directory containing SVG files
  svg_dir: assets/icons/svg
''';

    await configFile.writeAsString(content);

    final svgDir = Directory('assets/icons/svg');
    if (!await svgDir.exists()) {
      await svgDir.create(recursive: true);
      print('✓ Created SVG directory: assets/icons/svg');
    }

    print('✓ Created flutter_polyicon.yaml');
    print('\nNext steps:');
    print('  1. Add SVG files to assets/icons/svg/');
    print('  2. Run: flutter_polyicon generate');
  }
}
