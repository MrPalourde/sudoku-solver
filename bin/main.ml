open Sudoku

let () =
  let grid = Array.make_matrix 9 9 0 in
  print_matrix grid;
  print_newline ();
  let solved = solve grid in
  if solved then print_matrix grid
