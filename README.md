# Sudoku Solver

## What it does
A sudoku solver written in OCaml using backtracking with MRV (Minimum Remaining Values) heuristic.

## Algorithm

### Naive backtracking
The base approach is simple: find the first empty cell, try values 1-9, recurse, backtrack if stuck. It works, but performance collapses on hard grids the solver wastes time exploring branches that are obviously wrong.

### MRV heuristic
Instead of picking the first empty cell, pick the one with the fewest valid candidates. A cell with only 2 possible values is a much better starting point than one with 7. (less branching, less backtracking)
The change is localized to find_empty_cell: scan all empty cells, count their candidates, return the one with the minimum.

## Benchmarks
100 randomly generated grids per difficulty, measured end-to-end.
 
| Difficulty | Without MRV | With MRV | Speedup |
|------------|-------------|----------|---------|
| solved     | ~2 µs       | ~2.6 µs  | —       |
| easy       | ~320 µs     | ~361 µs  | ~1x     |
| medium     | ~1.3 ms     | ~311 µs  | 4x      |
| hard       | ~110 ms     | ~602 µs  | **180x** |
| empty      | ~1 ms       | ~475 µs  | 2x      |

**Why is empty faster than hard?**
The grids that are empty have millions of possibilities, so the first one that is found is usually correct. On the other hand, the hard ones often have only one solution, so the solver needs to backtrack more times.

## Usage

### Build
```bash
dune build
```
 
### Run tests
```bash
# unit tests
dune test test/test_sudoku_solver.exe
 
# stress tests
./_build/default/test/test_sudoku_solver_stress.exe
```

### Run on a specific grid
#### Method 1 (Modify the default grid on main.ml)
```bash
open Sudoku

let () =
  let grid = Array.make_matrix 9 9 0 in (* CHANGE THE GRID HERE *)
  print_matrix grid;
  print_newline ();
  let solved = solve grid in
  if solved then print_matrix grid
```
#### Method 2 (Import the library to run on your code)
```bash
open Sudoku
let grid = (* PUT YOUT GRID HERE *)
let solved = solve grid in
if solved then print_matrix grid
```

## What I learned

**Benchmarking is easy to get wrong.** My first stress test showed all difficulties taking the same time because the solver was modifying the grid in place. After the first solve, every subsequent call was working on an already-solved grid. Fixing it meant copying the grid before each call.
 
**Heuristics matter more than I expected.** The naive solver and the MRV solver are nearly identical in code, but 180x apart on hard grids. The choice of *which* cell to fill next completely changes the shape of the search tree.
