# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-12-05

### Added
- Initial release of flutter_polyicon
- `init` command to create configuration file and directory structure
- `generate` command to convert SVG files to icon fonts
- YAML-based configuration system
- Support for TTF/OTF font generation
- Automatic Flutter Dart class generation with IconData constants
- Verbose mode for debugging (`-v, --verbose`)
- Recursive directory scanning (`-r, --recursive`)
- Custom configuration file path support (`-c, --config`)
- Comprehensive error handling and validation
- Progress indicators and colored console output
- SVG validation and duplicate detection
- Automatic directory creation for outputs
- Generated code includes embedded SVG previews

### Features
- Zero-configuration defaults
- One-command workflow (init + generate)
- Type-safe icon constants
- Works with any SVG source (Figma, Sketch, Illustrator, etc.)
- Offline operation (no external services)
- Support for multiple icon sets per project

### Documentation
- Comprehensive README with examples
- Command-line help text
- Troubleshooting guide
- CI/CD integration examples
- Comparison with alternatives

---

## [Unreleased]

### Planned Features
- Watch mode for automatic regeneration on SVG changes
- Embedded icon library support (Material, FontAwesome, etc.)
- Preview mode (HTML preview of all icons)
- Figma plugin integration
- VS Code extension
- Build_runner integration
- Custom character code mapping
- Icon tree-shaking support

---

[0.1.0]: https://github.com/ilikerobots/polyicon/releases/tag/v0.1.0
