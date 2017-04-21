open Ocamlnds_ofc

let run_reader () =
  let open Reader in
  let john = Person ("Johndoe", 101) in
  print_endline ((run show) john)

let run_state () =
  let open State in
  let (msg, state) = ((run show) "adit") in
  print_endline ("(" ^ msg ^ ", " ^ state ^ ")")

let () =
  run_state ();
  run_reader ()
