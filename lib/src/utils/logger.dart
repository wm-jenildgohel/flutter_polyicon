import 'dart:io';

class Logger {
  final bool verbose;

  Logger({this.verbose = false});

  void info(String message) {
    print('  $message');
  }

  void success(String message) {
    print('✓ $message');
  }

  void warning(String message) {
    print('⚠ $message');
  }

  void error(String message) {
    stderr.writeln('✗ Error: $message');
  }

  void detail(String message) {
    if (verbose) {
      print('  $message');
    }
  }

  void step(String message) {
    print('\n$message');
  }

  void progress(String message) {
    stdout.write('\r$message');
  }

  void clearProgress() {
    stdout.write('\r${' ' * 80}\r');
  }
}
