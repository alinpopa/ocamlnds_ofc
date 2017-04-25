open Ocamlnds_ofc
open Core.Std

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

let () =
  run_state ();
  run_reader ();
  run_stupid_convo_reader ();
  run_writer ()
