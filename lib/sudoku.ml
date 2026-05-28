let print_matrix grid =
  Array.iter (fun row ->
    Array.iter (fun x ->
      Printf.printf "%d " x
    ) row;
    print_newline ()
  ) grid

let is_number_correct number x y grid =
    let column m x =
        Array.to_list (Array.map (fun row -> row.(x)) m)
    in
    let line m y =
        Array.to_list m.(y)
    in
    let box m x y =
        let bx = (x / 3) * 3 in
        let by = (y / 3) * 3 in
        let acc = ref [] in
        for yy = by to by+2 do
            for xx = bx to bx+2 do
                acc := m.(yy).(xx) :: !acc
            done;
        done;
        List.rev !acc
    in
    let all = (line grid y) @ (column grid x) @ (box grid x y) in
    not(List.mem number all)

let count_candidates grid x y =
    let numbers_used = Array.make 10 false in
    for i = 0 to 8 do
        numbers_used.(grid.(y).(i)) <- true;
        numbers_used.(grid.(i).(x)) <- true;
        let by = (y / 3) * 3 + i/3 in
        let bx = (x / 3) * 3 + i mod 3 in
        numbers_used.(grid.(by).(bx)) <- true;
    done;
    let count = ref 0 in
    for i = 0 to 9 do
        if not numbers_used.(i) then incr count
    done;
    !count

let find_empty_cell grid =
    let best = ref None in
    let best_count = ref 10 in
    let n = Array.length grid in
    for y = 0 to n-1 do
        for x = 0 to n-1 do
            if grid.(y).(x) = 0 then begin
                let count = count_candidates grid x y in
                if count < !best_count then begin
                    best_count := count;
                    best := Some (x, y)
                end;
            end;
        done;
    done;
    !best

let rec try_numbers n m grid x y =
    if n > m then false
    else if is_number_correct n x y grid then (
        grid.(y).(x) <- n;
        if solve grid then true
        else (
            grid.(y).(x) <- 0;
            try_numbers (n+1) m grid x y
        )
    ) else
        try_numbers (n+1) m grid x y

and solve grid =
    let next_cell = find_empty_cell grid in
    match next_cell with
    | None -> true
    | Some(x, y) ->
            try_numbers 1 9 grid x y

