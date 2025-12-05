# Contributing

We welcome contributions! Please follow these guidelines to keep the project maintainable and consistent with SOLID, MVC, and clean‑code principles.

## Getting Started
1. Fork the repository.
2. Clone your fork locally.
3. Ensure you have the Dart SDK (`>=3.5.0 <4.0.0`).
4. Run `dart pub get` to install dependencies.

## Development Workflow
- **Branching**: Create a feature branch from `main`.
- **Testing**: Add unit tests under `test/` (if needed) and run `dart test`.
- **Linting**: Run `dart format .` and `dart analyze` before committing.
- **Commit Messages**: Follow conventional commits (e.g., `feat: add new icon set`).

## Code Quality
- **SOLID**: Each class should have a single responsibility.
- **MVC**: Keep UI‑related code separate from the generation logic.
- **Clean Code**: Use meaningful names, avoid deep nesting, and keep functions short.

## Submitting a Pull Request
1. Push your branch to your fork.
2. Open a PR against `main`.
3. Ensure all CI checks pass.
4. Provide a clear description of what the PR changes.

Thank you for helping improve `flutter_polyicon`!
