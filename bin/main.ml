open Ocamlnds_ofc
open Core

let string_of_list xs =
  let open String in
  "[" ^ (concat ~sep:"; " xs) ^ "]"

let run_reader () =
  let open Reader in
  let john = Person ("Johndoe", 101) in
  print_endline ((run show) john)

let run_stupid_convo_reader () =
  let open Reader in
  print_endline (string_of_list (run convo "John"))

let run_state () =
  let open State in
  let (msg, state) = ((run_state show) []) in
  print_endline ("(" ^ msg ^ ", " ^ (string_of_list state) ^ ")")

let run_writer () =
  let open Writer in
  let half x =
    let open String in
    tell [concat ["Just halved "; (string_of_int x); "!"]] >>= fun _ ->
    return (x / 2) in
  let (x, xs) = (run_writer (half 24 >>= half >>= half)) in
  print_endline ("(" ^ (string_of_int x) ^ ", " ^ (string_of_list xs) ^ ")")

let run_reader_ex () =
  let open Reader in
  let open Reader_ex in
  let db = create_db () in
  let _ = print_endline "Users:" in
  let _ = print_users db in
  let _ = print_endline "Passwords:" in
  let _ = print_pass db in
  let x = run (check_login 10 "pass01") db in
  let y = run (check_login 20 "pass01") db in
  let z = run (check_login 100 "pass01") db in
  print_endline (Printf.sprintf "X : %B, Y : %B, Z : %B" x y z)

let () =
  run_state ();
  run_reader ();
  run_stupid_convo_reader ();
  run_writer ();
  run_reader_ex ()
