# Հայ եմ (Hayem) — Հայկական Connections

> "Ապացուցիր որ հայ ես"

Daily word-category puzzle, NYT Connections-i nman, hayakan content-ov
(patmutyun, mshakуyt, sфyուrq, homaniшner).

## Status

- [x] Flutter project — game logic, UI, animations, share mechanic
- [x] Content database — 30 puzzle, 480 bar (1 amisya pilot)
- [x] CSV → Dart pipeline — content avelacnel/poxel hesht e
- [x] Git repo — version control setup
- [ ] Native speaker review (kategoria-ner 16-30-i hamar)
- [ ] App icon + store assets (Հ + 4x4 grid concept)
- [ ] iOS/Android build + TestFlight/Internal testing
- [ ] Apple Developer ($99) + Google Play Console ($25) accounts
- [ ] Store listing (screenshots, description)
- [ ] Submit for review
- [ ] Soft launch — Facebook Armenian groups
- [ ] ProductHunt launch

## Project structure

```
kaper_flutter/
├── lib/
│   ├── main.dart              # App entry, theme
│   ├── models/category.dart   # Puzzle/Category models
│   ├── data/puzzles.dart       # AUTO-GENERATED — don't edit directly
│   ├── screens/game_screen.dart
│   └── widgets/                # Tile, lives, solved row, result sheet
├── content_pipeline/
│   ├── puzzles_full.csv        # SOURCE OF TRUTH for content
│   ├── csv_to_dart.py          # Conversion script
│   └── README.md
└── README.md (this file)
```

## Quick start

```bash
flutter pub get
flutter run
```

## Updating content

```bash
cd content_pipeline
# edit puzzles_full.csv
python3 csv_to_dart.py puzzles_full.csv ../lib/data/puzzles.dart
```

## Monetization (post-pilot)

Free during pilot — no paywall, no payment infra needed yet.

Post-pilot flow: App Store/Google Play -> Wise (USD) -> Ameriabank (AMD/USD).
Subscriptions via Paddle (merchant of record, Wise payout).

Setup cost: $99 (Apple Developer/year) + $25 (Google Play, once) = $124.

## Brand

- Name: Հայ եմ (Hayem)
- Icon: "Հ" letter + 4x4 puzzle-grid background (purple #3C3489)
- Tagline: "Ապացուցիր որ հայ ես"
- Share format: emoji grid (🟪🟩🟨🟧), no spoilers
