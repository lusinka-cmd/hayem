# Content pipeline

## Inchpes avelacnel/poxel puzzles

1. `puzzles_full.csv`-ı edit anel (Excel/Sheets-ov, UTF-8 BOM-ov save anel)
2. Run conversion:

```bash
python3 csv_to_dart.py puzzles_full.csv ../lib/data/puzzles.dart
```

3. `flutter run` — nor content-ı immediately load kani

## CSV format

| Column | Tinch |
|---|---|
| puzzle_number | Or puzzle (1, 2, 3...) — petq e 16 row/puzzle (4 kategoria x 4 bar) |
| category_name | Kategoria anun |
| category_hint | Hint (Hayeren) |
| word | Hayeren bar |
| difficulty | 1=hesht, 2=mijin, 3=hazvadep |

## Rotation logic

`getTodayPuzzle()` puzzle.dart-um automatically rotate-ov e anum
puzzle 1-ic 30-ı, hetо kgna 1-ic norits (cycle).
Start date: 2025-01-06 (Day 1).

365 puzzle ttarvi hamar — full year, cycle chi krkn-vi.
