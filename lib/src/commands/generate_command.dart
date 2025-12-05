import 'dart:io';
import 'package:args/command_runner.dart';
import '../config/config_loader.dart';
import '../config/config_validator.dart';
import '../generator/icon_generator.dart';
import '../utils/logger.dart';
import '../utils/exceptions.dart';

class GenerateCommand extends Command {
  @override
  final String name = 'generate';

  @override
  final String description = 'Generate font and Dart class from SVGs.';

  GenerateCommand() {
    argParser
      ..addOption(
        'config',
        abbr: 'c',
        help: 'Path to the configuration file.',
        defaultsTo: 'flutter_polyicon.yaml',
      )
      ..addFlag(
        'verbose',
        abbr: 'v',
        help: 'Show verbose output.',
        negatable: false,
      )
      ..addFlag(
        'recursive',
        abbr: 'r',
        help: 'Recursively scan SVG directory.',
        negatable: false,
      );
  }

  @override
  Future<void> run() async {
    final configPath = argResults!['config'] as String;
    final verbose = argResults!['verbose'] as bool;
    final recursive = argResults!['recursive'] as bool;

    final logger = Logger(verbose: verbose);

    try {
      logger.step('🔍 Loading configuration from $configPath');
      final config = await ConfigLoader.load(configPath);
      logger.success('Configuration loaded');

      logger.detail('Validating configuration...');
      await ConfigValidator.validate(config);

      final generator = IconGenerator(
        config: config,
        logger: logger,
        recursive: recursive,
      );

      await generator.generate();
    } on ConfigException catch (e) {
      logger.error(e.toString());
      exit(65);
    } on ValidationException catch (e) {
      logger.error(e.toString());
      exit(65);
    } on GenerationException catch (e) {
      logger.error(e.toString());
      exit(1);
    } catch (e, stack) {
      logger.error('Unexpected error: $e');
      if (verbose) {
        logger.detail(stack.toString());
      }
      exit(1);
    }
  }
}
