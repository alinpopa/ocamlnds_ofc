type ('s, 'a) state = State of ('s -> 'a * 's)

let return a =
  State (fun s -> (a, s))

let (>>=) s f =
  match s with
  | State state ->
      State (fun s ->
        let (x, s) = state s in
        match (f x) with
        | State state -> state s)

let run s x =
  match s with
  | State f -> f x

let get_state =
  State (fun s -> (s, s))

let set_state s =
  State (fun _ -> ((), s))

let show =
  get_state >>= fun name ->
  (set_state "tintin") >>= fun _ ->
  return ("hello, " ^ name ^ "!")
