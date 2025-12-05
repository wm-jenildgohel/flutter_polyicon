# Flutter Polyicon
[![Pub Version](https://img.shields.io/pub/v/flutter_polyicon?color=blue)](https://pub.dev/packages/flutter_polyicon)
[![License](https://img.shields.io/badge/license-MIT-purple.svg)](LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/wm-jenildgohel/flutter_polyicon?style=social)](https://github.com/wm-jenildgohel/flutter_polyicon)
⚡️ **One‑shot icon font generator for Flutter** – turn your SVGs into a sleek, type‑safe icon font in seconds.

---

⚡️ **One‑shot icon font generator for Flutter** – turn your SVGs into a sleek, type‑safe icon font in seconds.

---

## 🎉 Why Flutter Polyicon?
- **Zero config** – works out of the box.
- **Fast** – font‑based icons are lightning‑quick.
- **Designer‑friendly** – any SVG export works.
- **Offline** – no external services needed.
- **Custom class name** – set `class_name` in the config.

---

## 🚀 Quick Start
1. **Install globally**
   ```bash
   dart pub global activate flutter_polyicon
   ```
2. **Initialize a config**
   ```bash
   flutter_polyicon init
   ```
   This creates `flutter_polyicon.yaml` and an `assets/icons/svg/` folder.
3. **Add your SVGs** to `assets/icons/svg/`.
4. **Generate**
   ```bash
   flutter_polyicon generate
   ```
   You’ll get a font file (`fonts/app_icons.ttf`) and a Dart class ready to import.

---

## 🛠️ Configuration (`flutter_polyicon.yaml`)
```yaml
# Icon set name (also the font family)
name: MyAppIcons

# Optional custom class name – defaults to PascalCase of `name`
class_name: MyIcons

output:
  # Font file location – defaults to `fonts/app_icons.ttf`
  font_file: fonts/app_icons.ttf
  # Dart class file location
  dart_file: lib/icons/app_icons.dart

input:
  # Directory containing your SVG files
  svg_dir: assets/icons/svg
```
- `class_name` lets you pick a Dart class name different from the set name.
- The default `font_file` path is now `fonts/app_icons.ttf` for a cleaner layout.

---

## 📱 Using the Generated Icons
```dart
import 'package:your_app/icons/app_icons.dart';

Icon(MyIcons.home);                     // basic usage
Icon(MyIcons.settings, size: 32);       // custom size
Icon(MyIcons.user, color: Colors.red); // custom color
```

---

## 💡 Tips & Tricks
- **Recursive scanning** – add `--recursive` to include subfolders.
- **Verbose mode** – `--verbose` shows detailed steps for debugging.
- **CI/CD** – see the GitHub Actions snippet in the docs to auto‑generate on SVG changes.

---

## 🤝 Contributing
Check `CONTRIBUTING.md` for our SOLID, MVC, and clean‑code guidelines. All contributions are welcome!

---

Made with ❤️ for the Flutter community.
