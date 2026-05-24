open Sudoku

let grid_easy = [|
  [|5;3;0;0;7;0;0;0;0|];
  [|6;0;0;1;9;5;0;0;0|];
  [|0;9;8;0;0;0;0;6;0|];
  [|8;0;0;0;6;0;0;0;3|];
  [|4;0;0;8;0;3;0;0;1|];
  [|7;0;0;0;2;0;0;0;6|];
  [|0;6;0;0;0;0;2;8;0|];
  [|0;0;0;4;1;9;0;0;5|];
  [|0;0;0;0;8;0;0;7;9|];
|]

let grid_medium = [|
  [|0;0;0;2;6;0;7;0;1|];
  [|6;8;0;0;7;0;0;9;0|];
  [|1;9;0;0;0;4;5;0;0|];
  [|8;2;0;1;0;0;0;4;0|];
  [|0;0;4;6;0;2;9;0;0|];
  [|0;5;0;0;0;3;0;2;8|];
  [|0;0;9;3;0;0;0;7;4|];
  [|0;4;0;0;5;0;0;3;6|];
  [|7;0;3;0;1;8;0;0;0|];
|]

let grid_hard = [|
  [|0;0;0;0;0;0;0;1;2|];
  [|0;0;0;0;0;7;0;0;0|];
  [|0;0;1;0;9;0;0;0;0|];
  [|0;0;0;0;0;0;4;0;0|];
  [|0;0;0;5;0;0;0;0;0|];
  [|0;0;0;0;0;0;0;0;0|];
  [|0;7;0;0;0;0;0;0;0|];
  [|0;0;0;0;0;0;0;0;0|];
  [|3;0;0;0;0;0;0;0;0|];
|]

let grid_solved = [|
  [|5;3;4;6;7;8;9;1;2|];
  [|6;7;2;1;9;5;3;4;8|];
  [|1;9;8;3;4;2;5;6;7|];
  [|8;5;9;7;6;1;4;2;3|];
  [|4;2;6;8;5;3;7;9;1|];
  [|7;1;3;9;2;4;8;5;6|];
  [|9;6;1;5;3;7;2;8;4|];
  [|2;8;7;4;1;9;6;3;5|];
  [|3;4;5;2;8;6;1;7;9|];
|]

let test_empty () =
    let grid_empty = Array.make_matrix 9 9 0 in
    let solved = solve grid_empty in
    solved

let test_easy () =
    let solved = solve grid_easy in
    solved

let test_medium () =
    let solved = solve grid_medium in
    solved

let test_hard () =
    let solved = solve grid_hard in
    solved

let test_solved () =
    let solved = solve grid_solved in
    solved

let tests = [
  test_empty;
  test_easy;
  test_medium;
  test_hard;
  test_solved;
]

let run_test name f =
  let result = f () in
  if result then print_endline ("[ OK ] " ^ name)
  else print_endline ("[FAIL] " ^ name)

let () =
  run_test "empty" test_empty;
  run_test "easy" test_easy;
  run_test "medium" test_medium;
  run_test "hard" test_hard;
  run_test "solved" test_solved;

