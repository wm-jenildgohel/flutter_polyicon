import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:flutter_polyicon/src/commands/init_command.dart';
import 'package:flutter_polyicon/src/commands/generate_command.dart';

void main(List<String> arguments) async {
  final runner = CommandRunner<void>(
      'flutter_polyicon', 'A CLI tool for generating Flutter icon fonts from SVGs.')
    ..addCommand(InitCommand())
    ..addCommand(GenerateCommand());

  try {
    await runner.run(arguments);
  } catch (e) {
    print('Error: $e');
    exit(64); // Exit code for usage error
  }
}
