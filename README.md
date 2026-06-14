# Կапер — Հаyakan Connections

Հаyeren barakhaghаkh, orakarg 4 kategorianеrov.

## Project structure

```
lib/
  main.dart              # App entry point + theme
  models/
    category.dart        # Category & Puzzle models
  data/
    puzzles.dart         # All daily puzzles content
  screens/
    game_screen.dart     # Main game UI + logic
  widgets/
    tile_widget.dart     # Word tile with animations
    solved_row_widget.dart
    lives_widget.dart
    result_sheet.dart    # End-of-game bottom sheet
```

## Setup — 3 qayl

```bash
# 1. Flutter install (https://flutter.dev)
flutter --version   # piti lini 3.x+

# 2. Dependencies
cd kaper_flutter
flutter pub get

# 3a. iOS simulator-um
open -a Simulator
flutter run

# 3b. Android emulator-um  
flutter run

# 3c. Release APK (Android)
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk

# 3d. Release iOS (macOS + Xcode petq e)
flutter build ipa --release
```

## Content avelacel / poxel

`lib/data/puzzles.dart` faylum kategorianerı poxel.

Amen Puzzle-i hamar petq e 4 Category:
- difficulty 0 = hesht (purple)
- difficulty 1 = mijin (green)  
- difficulty 2 = dzhvar (amber)
- difficulty 3 = shat dzhvar (coral)

## Viral share format

Kaperı share anum e sа:
```
Կапер #42
✅ 3/4
🟪🟩🟧🟨
🟪🟩🟨🟧
🟪🟩🟩🟨
hayakankaper.app
```

## Monetization (hajakа roadmap)

- Free: 1 puzzle/day
- Premium ($1.99/month): archive + hints + stats
- Launch: ProductHunt + Armenian Facebook groups
