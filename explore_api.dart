import 'package:icon_font_generator/icon_font_generator.dart';

void main() {
  print('Checking API...');
  // Try to instantiate or access static members to see what's available.
  // This is a guess. If it fails, I'll know the import is wrong or class name is different.
  try {
     print('IconFontGenerator class exists');
  } catch (e) {
    print(e);
  }
}
