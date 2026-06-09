[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

# iux
Application design system built with Flutter and custom themeable UI components 

## Table of Contents
- [Getting Started](#getting-started)
- [Using Mason for Code Generation](#using-mason-for-code-generation)
    - [Bricks](#bricks)
        - [page](#page)
        - [freezed_class](#freezed_class)
- [Project Structure](#project-structure)
- [How to Add New Icons](#how-to-add-new-icons)

## Getting Started
This project uses [FVM](https://fvm.app/documentation/getting-started/installation) to handle the flutter version so before running any **Flutter** or **Dart** command, you should prefix it with **fvm** e.g.:
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
#!/usr/bin/bash

fvm dart run mason_cli:mason "$@"
```
*(make sure to make the file executable with `chmod +x fvm_mason`)* and then use `fvm_mason` directly

### Bricks
Brick creation should be invoked inside the `mason` folder.
#### Brick: `page`
Generates a complete new page, including the UI, **BLoC** state management (`freezed`), and navigation configuration (`auto_route`).\
**Note:** Remember to register the new route in the router.

**Usage**
```bash
fvm_mason make page -o ../lib/ui
```

**Prompts**
- `page_name`: The name of the page (e.g., *user profile*, *home*) — naming conventions are handled automatically

**Generated Structure**
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
fvm_mason make freezed_class -o <folder path>
```

**Prompts**
- `class_name`: The name of the data class (e.g., *project data*) — naming conventions are handled automatically

**Generated Structure**
```plaintext
{{class_name.snakeCase()}}.dart
```

## Project Structure
This project follows the [Flutter package structure](https://docs.flutter.dev/app-architecture/case-study#package-structure) recommended in the official documentation.

## How to Add New Icons
This project uses a custom icon font generated via [FontForge](https://fontforge.org). Follow this guide to add new icons to the existing set.

### File Locations
* **FontForge Project File:** `iux_icons_font.sfd` (located in the project root)
* **Exported Font File:** `assets/fonts/iux_icons_font.ttf`
* **Flutter Mapping Class:** `lib/ui/core/icons/icons.dart`

### Step-by-Step Procedure
#### 1. Editing the FontForge Project
1. Open **FontForge** and load the `iux_icons_font.sfd`.
2. Locate the first available empty cell in the grid (sequentially after the last existing icon).
3. Double-click the empty cell to open the editor view.
4. Import your vector asset (`File > Import`) or draw your icon.
   * *2048 UPM Rule:* Ensure the icon sits properly on the **Baseline (0)** and fits within the **2048** unit grid, leaving about 1 or 2 grid squares as a padding/side bearing on each side.
5. Set the glyph properties:
   * Go to **Glyph > Glyph Info**.
   * In the **Glyph Name** field, type a descriptive name (e.g., `shopping-cart` or `arrow-back`).
   * In the **Unicode** field, assign the next available hexadecimal value in the **Private Use Area (PUA)** (e.g., `U-E001`, `U-E002`, etc.).
6. Save the project (`File > Save` or `Ctrl + S`) to update the `.sfd` source file.

#### 2. Exporting the .ttf File
1. In FontForge, go to **File > Generate Fonts...**
2. Select **TrueType** from the format dropdown menu.
3. Overwrite the existing font file in the assets folder:
   `assets/fonts/iux_icons_font.ttf`
4. If FontForge displays validation warnings during generation (e.g., *Non-integral coordinates*), you can usually ignore them or click *Fix*.

#### 3. Updating the Flutter Class
Open the icons class file in `lib/ui/core/icons/icons.dart` and declare a new static constant mapping to the exact Unicode hex code you just defined in FontForge.

```dart
abstract class IuxIcons {
  static const String _fontFamily = 'iuxIconsFont'; // Must match the one in pubspec.yaml

  // Existing icons...

  // Add your new icon here with the unicode chosen in FontForge (0xe001 in this example)
  static const IconData shoppingCart = IconData(0xe001, fontFamily: _fontFamily);
}