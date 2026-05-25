open Sudoku

let run_test_stress name grids =
  let n = Array.length grids in
  let start_time = Unix.gettimeofday () in
  Array.iter (fun grid ->
    ignore (solve (Array.map Array.copy grid))
  ) grids;
  let end_time = Unix.gettimeofday () in
  let duration = end_time -. start_time in
  Printf.printf "[ %d ] %s in : %.5f seconds\n" n name duration

let () =
  run_test_stress "solved" Grids.solved_grids;
  run_test_stress "easy"   Grids.easy_grids;
  run_test_stress "medium" Grids.medium_grids;
  run_test_stress "hard"   Grids.hard_grids;
  run_test_stress "empty"  Grids.empty_grids
