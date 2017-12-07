open Core.Caml

module Usernames = Map.Make(struct type t = int let compare = compare end)
module Passwords = Map.Make(String)

type db = string Usernames.t * string Passwords.t

type 'a dbreader = DbReader of ('a, db) Reader.reader

let find_username userid =
  Reader.Reader (
    fun (usernames, _) ->
      Usernames.find_opt userid usernames
  )

let check_password username password =
  Reader.Reader (
    fun (_, passwords) ->
      match (Passwords.find_opt username passwords) with
      | Some pass -> String.equal pass password
      | None -> false
  )

let check_login userid password =
  let open Reader in
  find_username userid >>= fun username ->
    match username with
    | Some u -> check_password u password
    | None -> return false

let create_db () =
  let users = List.fold_left (fun acc (k, v) ->
    Usernames.(add k v acc)
  ) Usernames.empty [
    (10, "user01");
    (20, "user02");
    (30, "user03");
    (40, "user04");
    (50, "user05")
  ] in
  let pass = List.fold_left (fun acc (k, v) ->
    Passwords.(add k v acc)
  ) Passwords.empty [
    ("user01", "pass01");
    ("user02", "pass02");
    ("user03", "pass03");
    ("user04", "pass04");
    ("user05", "pass05")
  ] in
  (users, pass)

let print_users (users, _) =
  Usernames.iter (fun k v ->
    print_endline ((string_of_int k) ^ " - " ^ v)
  ) users

let print_pass (_, pass) =
  Passwords.iter (fun k v ->
    print_endline (k ^ " - " ^ v)
  ) pass
