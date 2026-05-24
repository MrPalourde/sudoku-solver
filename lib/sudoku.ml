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

let find_empty_cell grid =
    let result = ref None in
    let n = Array.length grid in
    for y = 0 to n-1 do
        for x = 0 to n-1 do
            if grid.(y).(x) = 0 && !result = None then
                result :=Some (x, y)
        done;
    done;
    !result

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

