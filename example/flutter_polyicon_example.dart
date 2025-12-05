// Example usage of flutter_polyicon CLI tool
// This demonstrates how to use the generated icon font in a Flutter app

import 'package:flutter/material.dart';

// After running:
// 1. flutter_polyicon init
// 2. Add SVG files to assets/icons/svg/
// 3. flutter_polyicon generate
//
// You'll get a generated file like lib/icons/app_icons.dart
// Import and use it like this:

// import 'package:your_app/icons/app_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Icon Font Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Example usage (replace AppIcons with your generated class name):
              // Icon(AppIcons.home, size: 48),
              // Icon(AppIcons.settings, size: 48),
              // Icon(AppIcons.user, size: 48),

              const Text(
                'Add your generated icons here!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Steps:\n'
                '1. Run: flutter_polyicon init\n'
                '2. Add SVG files to assets/icons/svg/\n'
                '3. Run: flutter_polyicon generate\n'
                '4. Import and use the generated class',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
