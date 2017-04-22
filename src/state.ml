type ('s, 'a) state = State of ('s -> 'a * 's)

let run_state s x =
  match s with
  | State f -> f x

let return a =
  State (fun s -> (a, s))

let (>>=) m k =
  State (fun s ->
    let (a, s') = run_state m s in
    run_state (k a) s')

let push x =
  State (fun xs ->
    ((), x :: xs))

let pop =
  State (fun xs ->
    match xs with
    | x :: xs -> (Some x, xs)
    | [] -> (None, xs))

let string_of_opt x =
  match x with
  | Some x -> x
  | None -> ""

let show =
  push "John" >>= fun _ ->
  pop >>= fun firstname ->
  push "Doe" >>= fun _ ->
  push "X" >>= fun _ ->
  push "Y" >>= fun _ ->
  push "Z" >>= fun _ ->
  pop >>= fun surname ->
  return ("hello: " ^ (string_of_opt firstname) ^ ", " ^ (string_of_opt surname) ^ "!")
