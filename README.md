[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

# iux
Application design system built with Flutter using [ForUI](https://forui.dev) for themeable UI components. For a complete list of available components, see the [ForUI documentation](https://forui.dev/docs).

## Table of Contents
- [Getting Started](#getting-started)
- [Using Mason for Code Generation](#using-mason-for-code-generation)
    - [Bricks](#bricks)
        - [page](#page)
        - [freezed_class](#freezed_class)
- [Project Structure](#project-structure)

## Getting Started
This project requires [FVM](https://fvm.app/documentation/getting-started/installation) to manage its Flutter SDK version. Before running any Flutter or Dart command, make sure the required Flutter SDK version, specified in `.fvmrc`, is installed. You can check which Flutter SDK versions are currently installed with:
```bash
fvm list
```
If the required version is not installed, install it with:
```bash
fvm install <flutter-version>
``` 
After installing the required version, set it as the project's Flutter SDK with:
```bash
fvm use <flutter-version>
```
then restart your editor so that it detects the newly configured Flutter SDK.

To run any Flutter or Dart command you should prefix it with `fvm`. For example:
```bash
fvm flutter run
```
if you use vs-code directly then it doesn't matter because inside `.vscode/settings.json` is specified the line `"dart.flutterSdkPath": ".fvm/versions/3.44.1"`.

Before running the project for the first time, you need to generate the required code using `build_runner`:
```bash
fvm dart run build_runner build
```
This generates files for `freezed`, `auto_route`, and other code generation packages used in the project.

### Using Mason for Code Generation
Mason is installed as local dev-dependency, so to generate code templates using the bricks in `mason/bricks` you should do:
```bash
fvm dart run mason_cli:mason
```
or to avoid writing every time the command you can save the following as `fvm_mason` in a directory in your `PATH`:
```bash
#!/bin/bash

fvm dart run mason_cli:mason "$@"
```
*(make sure to make the file executable with `chmod +x fvm_mason`)* and then use `fvm_mason` directly

### Bricks
Brick creation should be invoked inside the `mason` folder.
#### Brick: `page`
Generates a complete new page, including the UI, **Cubit** or **BLoC** state management (`freezed`), and navigation configuration (`auto_route`).\
**Note:** Remember to register the new route in the router.

**Usage**
```bash
fvm_mason make page -o ../lib/ui
```

**Prompts**
- `page_name`: The name of the page (e.g., *user profile*, *home*) — naming conventions are handled automatically
- `state_management`: The state management architecture (`cubit` [default] or `bloc`)

**Generated Structure**

*When choosing **Cubit** (default):*
```plaintext
{{page_name.snakeCase()}}/
├── cubit/
│   ├── {{page_name.snakeCase()}}_cubit.dart
│   └── {{page_name.snakeCase()}}_state.dart
└── {{page_name.snakeCase()}}_page.dart
```

*When choosing **BLoC**:*
```plaintext
{{page_name.snakeCase()}}/
├── bloc/
│   ├── {{page_name.snakeCase()}}_bloc.dart
│   ├── {{page_name.snakeCase()}}_event.dart
│   └── {{page_name.snakeCase()}}_state.dart
└── {{page_name.snakeCase()}}_page.dart
```
#### Brick: `freezed_class`
Generates a Freezed immutable data class with built-in equality, `copyWith`, and `toString` implementations.

**Usage**
```bash
fvm_mason make freezed_class -o <folder-path>
```

**Prompts**
- `class_name`: The name of the data class (e.g., *project data*) — naming conventions are handled automatically

**Generated Structure**
```plaintext
{{class_name.snakeCase()}}.dart
```

## Project Structure
This project follows the [Flutter package structure](https://docs.flutter.dev/app-architecture/case-study#package-structure) recommended in the official documentation.