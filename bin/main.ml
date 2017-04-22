open Ocamlnds_ofc
open Core.Std

let run_reader () =
  let open Reader in
  let john = Person ("Johndoe", 101) in
  print_endline ((run show) john)

let string_of_list xs =
  "[" ^ (String.concat ~sep:";" xs) ^ "]"

let run_state () =
  let open State in
  let (msg, state) = ((run_state show) []) in
  print_endline ("(" ^ msg ^ ", " ^ (string_of_list state) ^ ")")

let () =
  run_state ();
  run_reader ()
