open Ocamlnds_ofc.Reader

let run_reader () =
  let john = Person ("Johndoe", 101) in
  print_endline ((run show) john)

let () =
  run_reader ()
