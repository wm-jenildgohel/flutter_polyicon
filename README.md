# Flutter Polyicon

**One-shot icon font generator for Flutter.** Convert SVG files to production-ready icon fonts with a single command.

[![Pub Version](https://img.shields.io/pub/v/flutter_polyicon?color=blue)](https://pub.dev/packages/flutter_polyicon)
[![License](https://img.shields.io/badge/license-MIT-purple.svg)](LICENSE)

Stop managing individual SVG assets. Generate type-safe, font-based icons from your SVG exports in seconds.

---

## Why Flutter Polyicon?

✓ **Zero Configuration** - Sensible defaults, works out of the box
✓ **One Command Setup** - `init` and `generate`, that's it
✓ **Type Safe** - Generated Dart class with IconData constants
✓ **Designer Friendly** - Works with any SVG export (Figma, Sketch, Illustrator)
✓ **Performance** - Font-based icons are faster than runtime SVG parsing
✓ **Offline First** - No external services or web dependencies

---

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [Commands](#commands)
- [Configuration](#configuration)
- [Usage in Flutter](#usage-in-flutter)
- [Advanced Usage](#advanced-usage)
- [Comparison](#comparison-with-alternatives)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

---

## Installation

### Global Activation (Recommended)

Install flutter_polyicon globally to use from anywhere:

```bash
dart pub global activate flutter_polyicon
```

### Local Development

Or add to your project's `dev_dependencies`:

```yaml
dev_dependencies:
  flutter_polyicon: ^0.1.0
```

Then run:

```bash
dart pub get
```

---

## Quick Start

### 60 Second Setup

**1. Initialize configuration:**

```bash
flutter_polyicon init
```

This creates:
- `flutter_polyicon.yaml` - Configuration file
- `assets/icons/svg/` - Directory for your SVG files

**2. Add your SVG files:**

```bash
assets/icons/svg/
  ├── home.svg
  ├── settings.svg
  └── user.svg
```

**3. Generate icons:**

```bash
flutter_polyicon generate
```

**4. Use in Flutter:**

```dart
import 'package:your_app/icons/app_icons.dart';

Icon(Myappicons.home, size: 24)
Icon(Myappicons.settings, color: Colors.blue)
Icon(Myappicons.user)
```

That's it! 🎉

---

## Commands

### `init` - Initialize Configuration

Creates a configuration file and SVG directory structure.

```bash
flutter_polyicon init
```

**Options:**

| Flag | Description |
|------|-------------|
| `-f, --force` | Overwrite existing configuration file |

**Example:**

```bash
# Create new config
flutter_polyicon init

# Overwrite existing config
flutter_polyicon init --force
```

---

### `generate` - Generate Icon Font

Converts SVG files to icon font and generates Flutter Dart class.

```bash
flutter_polyicon generate
```

**Options:**

| Flag | Description | Default |
|------|-------------|---------|
| `-c, --config <path>` | Path to configuration file | `flutter_polyicon.yaml` |
| `-v, --verbose` | Show detailed output | `false` |
| `-r, --recursive` | Scan subdirectories for SVGs | `false` |

**Examples:**

```bash
# Basic generation
flutter_polyicon generate

# Custom config file
flutter_polyicon generate --config custom_config.yaml

# Verbose output for debugging
flutter_polyicon generate --verbose

# Scan subdirectories recursively
flutter_polyicon generate --recursive
```

**Output:**

```
🔍 Loading configuration from flutter_polyicon.yaml
✓ Configuration loaded

📁 Scanning for SVG files in assets/icons/svg
✓ Found 3 SVG files

⚙️  Converting SVGs to font...

💾 Writing font file...
✓ Font generated: lib/fonts/app_icons.ttf

📝 Generating Flutter class...
✓ Dart class generated: lib/icons/app_icons.dart

✨ Generation complete in 0.19s

Generated 3 icons:
  - Font: lib/fonts/app_icons.ttf
  - Class: lib/icons/app_icons.dart

Next steps:
  1. Add font to pubspec.yaml
  2. Import and use in your Flutter app
```

---

## Configuration

### Configuration File: `flutter_polyicon.yaml`

```yaml
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
```

### Configuration Options

| Field | Type | Required | Description | Default |
|-------|------|----------|-------------|---------|
| `name` | String | Yes | Name of icon set and generated class | - |
| `output.font_file` | String | Yes | Path for generated font file (.ttf/.otf) | - |
| `output.dart_file` | String | Yes | Path for generated Dart class | - |
| `input.svg_dir` | String | Yes | Directory containing SVG files | - |

### Validation Rules

- **Name:** Must start with letter, contain only letters, numbers, underscores
- **Font File:** Must end with `.ttf` or `.otf`
- **Dart File:** Must end with `.dart`
- **SVG Directory:** Must exist and contain at least one `.svg` file

---

## Usage in Flutter

### Step 1: Add Font to `pubspec.yaml`

After generating icons, add the font to your Flutter project:

```yaml
flutter:
  fonts:
    - family: MyAppIcons
      fonts:
        - asset: lib/fonts/app_icons.ttf
```

**Important:** The `family` name must match the `name` in `flutter_polyicon.yaml`.

### Step 2: Import and Use

```dart
import 'package:your_app/icons/app_icons.dart';

// Basic usage
Icon(Myappicons.home)

// With size
Icon(Myappicons.settings, size: 32)

// With color
Icon(Myappicons.user, color: Colors.red)

// In buttons
IconButton(
  icon: Icon(Myappicons.home),
  onPressed: () {},
)

// In list tiles
ListTile(
  leading: Icon(Myappicons.settings),
  title: Text('Settings'),
)
```

### Generated Code Structure

The generated Dart file includes:

```dart
class Myappicons {
  const Myappicons._();

  static const iconFontFamily = 'MyAppIcons';

  /// Font icon named "home"
  /// [SVG preview embedded as base64 image]
  static const IconData home = IconData(0xe000, fontFamily: iconFontFamily);

  /// Font icon named "settings"
  /// [SVG preview embedded as base64 image]
  static const IconData settings = IconData(0xe001, fontFamily: iconFontFamily);

  // ... more icons
}
```

---

## Advanced Usage

### Custom Configuration Path

Use different configurations for different icon sets:

```bash
# Material Design icons
flutter_polyicon generate --config configs/material_icons.yaml

# Brand icons
flutter_polyicon generate --config configs/brand_icons.yaml
```

### Recursive Directory Scanning

Organize SVGs in subdirectories:

```
assets/icons/svg/
  ├── actions/
  │   ├── edit.svg
  │   └── delete.svg
  ├── navigation/
  │   ├── home.svg
  │   └── back.svg
  └── social/
      ├── share.svg
      └── like.svg
```

Generate with recursive flag:

```bash
flutter_polyicon generate --recursive
```

### Multiple Icon Sets

Manage multiple icon sets in one project:

**Config 1: `ui_icons.yaml`**

```yaml
name: UiIcons
output:
  font_file: lib/fonts/ui_icons.ttf
  dart_file: lib/icons/ui_icons.dart
input:
  svg_dir: assets/icons/ui/
```

**Config 2: `brand_icons.yaml`**

```yaml
name: BrandIcons
output:
  font_file: lib/fonts/brand_icons.ttf
  dart_file: lib/icons/brand_icons.dart
input:
  svg_dir: assets/icons/brand/
```

Generate both:

```bash
flutter_polyicon generate --config ui_icons.yaml
flutter_polyicon generate --config brand_icons.yaml
```

### SVG File Naming

Icon names are derived from SVG filenames:

| Filename | Generated Constant | Notes |
|----------|-------------------|-------|
| `home.svg` | `Myappicons.home` | Simple lowercase |
| `user-profile.svg` | `Myappicons.user_profile` | Hyphens → underscores |
| `2x-speed.svg` | `Myappicons.icon_2x_speed` | Prefixed if starts with number |
| `my__icon.svg` | `Myappicons.my_icon` | Multiple underscores collapsed |

### Verbose Mode for Debugging

See detailed output during generation:

```bash
flutter_polyicon generate --verbose
```

Output includes:
- Each SVG file loaded
- Validation messages
- File writing details
- Stack traces for errors

---

## Comparison with Alternatives

| Feature | flutter_polyicon | icon_font_generator | flutter_iconfont_generator |
|---------|-----------------|--------------------|-----------------------------|
| CLI Tool | ✓ | ✓ | ✓ |
| Zero-config init | ✓ | ✗ | ✗ |
| YAML config | ✓ | ✓ | ✗ |
| Any SVG source | ✓ | ✓ | ✗ (iconfont.cn only) |
| Helpful errors | ✓ | ~ | ~ |
| Progress output | ✓ | ✗ | ~ |
| Verbose mode | ✓ | ✗ | ✗ |
| Recursive scan | ✓ | ~ | ✗ |
| Auto directory creation | ✓ | ✗ | ✗ |

---

## Troubleshooting

### Error: Configuration file not found

```
✗ Error: Configuration file not found: flutter_polyicon.yaml

Run "flutter_polyicon init" to create a configuration file
```

**Solution:** Run `flutter_polyicon init` first.

---

### Error: SVG directory does not exist

```
✗ Error: SVG directory does not exist: assets/icons/svg
Please create the directory and add SVG files
```

**Solution:**
1. Check path in `flutter_polyicon.yaml`
2. Create directory: `mkdir -p assets/icons/svg`
3. Add SVG files to the directory

---

### Error: No SVG files found

```
✗ Error: No SVG files found in: assets/icons/svg
Add .svg files to this directory or enable recursive scanning with --recursive
```

**Solution:**
- Add `.svg` files to the directory
- Or use `--recursive` if files are in subdirectories
- Ensure files have `.svg` extension (case-insensitive)

---

### Warning: Skipping invalid SVG

```
⚠ Skipping invalid SVG: broken_icon.svg (Invalid SVG XML: ...)
```

**Solution:**
- Open the SVG in a text editor
- Ensure it has valid XML structure
- Check that root element is `<svg>`
- Validate SVG syntax

---

### Icons not showing in Flutter app

**Symptoms:** Icons appear as blank boxes

**Solutions:**

1. **Check pubspec.yaml:** Ensure font is declared

```yaml
flutter:
  fonts:
    - family: MyAppIcons  # Must match config name
      fonts:
        - asset: lib/fonts/app_icons.ttf  # Must match actual path
```

2. **Hot Restart:** Font changes require full restart (not hot reload)

```bash
# Stop app and run again
flutter run
```

3. **Verify Import:** Check import path

```dart
import 'package:your_app/icons/app_icons.dart';  // Correct path
```

4. **Check Family Name:** Must match config

```yaml
# In flutter_polyicon.yaml
name: MyAppIcons  # This becomes the font family
```

---

### Performance: Large icon sets

For 100+ icons:
- Generation time: ~0.5-2 seconds
- Font file size: ~5-20KB
- No runtime performance impact

**Tip:** Split into multiple icon sets if needed (see [Multiple Icon Sets](#multiple-icon-sets))

---

### Dependency Conflict with function_linter

**Issue:** If installed as a local dev_dependency alongside `function_linter ^1.1.0`, you may encounter an analyzer version conflict.

**Solution (Recommended):**

Install flutter_polyicon **globally** to avoid conflicts:

```bash
dart pub global activate flutter_polyicon
flutter_polyicon generate
```

Global installation is the recommended approach and isolates dependencies from your project.

**Why This Happens:**

flutter_polyicon depends on `icon_font_generator` which requires `analyzer <7.0.0`, while `function_linter ^1.1.0` requires `analyzer ^7.4.5`.

**Status:**

This will be resolved in version 0.2.0 by updating to newer dependencies. Track progress in [GitHub Issues](https://github.com/ilikerobots/polyicon/issues).

**Alternative Workaround (If you must use local installation):**

1. Temporarily comment out `function_linter` in pubspec.yaml
2. Run `flutter_polyicon generate`
3. Restore `function_linter`
4. Generated files are committed, so you won't need to re-run often

---

## SVG Requirements

### Supported SVG Features

✓ Paths (`<path>`)
✓ Basic shapes (`<rect>`, `<circle>`, `<ellipse>`, `<line>`, `<polygon>`, `<polyline>`)
✓ Groups (`<g>`)
✓ Transforms
✓ Multiple paths per icon

### Best Practices

1. **Export from design tools:**
   - Figma: Export as SVG
   - Sketch: Export → SVG
   - Illustrator: Save As → SVG → "Presentation Attributes"

2. **Optimize SVGs:**
   - Remove unnecessary metadata
   - Flatten layers
   - Convert text to paths
   - Use single color (stroke/fill)

3. **Consistent sizing:**
   - Use same viewBox across icons (e.g., `0 0 24 24`)
   - Icons are automatically normalized during generation

### Example SVG Structure

```xml
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
  <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
  <polyline points="9 22 9 12 15 12 15 22"/>
</svg>
```

---

## CI/CD Integration

### GitHub Actions

Automate icon generation on SVG changes:

```yaml
name: Generate Icons

on:
  push:
    paths:
      - 'assets/icons/svg/**'

jobs:
  generate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - uses: dart-lang/setup-dart@v1

      - name: Install flutter_polyicon
        run: dart pub global activate flutter_polyicon

      - name: Generate icons
        run: flutter_polyicon generate

      - name: Commit generated files
        run: |
          git config user.name "GitHub Actions"
          git config user.email "actions@github.com"
          git add lib/fonts/ lib/icons/
          git commit -m "chore: regenerate icons" || exit 0
          git push
```

---

## Examples

### Full Project Example

See [example/](example/) directory for complete Flutter app using generated icons.

### Quick Examples

**Basic Icon Set:**

```dart
// After generation
Icon(Myappicons.home, size: 24)
Icon(Myappicons.settings)
Icon(Myappicons.user, color: Colors.blue)
```

**Navigation Bar:**

```dart
BottomNavigationBar(
  items: [
    BottomNavigationBarItem(
      icon: Icon(Myappicons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Myappicons.search),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: Icon(Myappicons.user),
      label: 'Profile',
    ),
  ],
)
```

**Custom Button:**

```dart
ElevatedButton.icon(
  icon: Icon(Myappicons.download),
  label: Text('Download'),
  onPressed: () {},
)
```

---

## Contributing

Contributions are welcome! This project is part of the FlutterIcon ecosystem.

### Report Issues

Found a bug or have a feature request? [Open an issue](https://github.com/ilikerobots/polyicon/issues)

### Development

```bash
# Clone repository
git clone https://github.com/ilikerobots/polyicon.git

# Navigate to flutter_polyicon
cd polyicon/flutter_polyicon

# Install dependencies
dart pub get

# Run locally
dart run bin/flutter_polyicon.dart --help
```

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Credits

- Built on top of [icon_font_generator](https://pub.dev/packages/icon_font_generator)
- Part of the [FlutterIcon](https://fluttericon.com) ecosystem
- Inspired by the need for better Flutter icon tooling

---

## Links

- [Pub.dev Package](https://pub.dev/packages/flutter_polyicon)
- [GitHub Repository](https://github.com/ilikerobots/polyicon)
- [FlutterIcon Website](https://fluttericon.com)
- [Issue Tracker](https://github.com/ilikerobots/polyicon/issues)

---

Made with ❤️ for the Flutter community
