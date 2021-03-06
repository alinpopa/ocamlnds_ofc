type ('a, 'b) reader = Reader of ('a -> 'b)
type person = Person of (string * int)

let run r e =
  match r with
  | Reader f -> f e

let return x =
  Reader (fun _ -> x)

let (>>=) r g =
  match r with
  | Reader f -> Reader (fun env -> run (g (f env)) env)

let ask =
  Reader (fun x -> x)

let get_name =
  ask >>= fun p ->
    match p with
    | Person (name, _) -> return ("Hello! My name is " ^ name)

let get_age =
  ask >>= fun p ->
    match p with
    | Person (_, age) -> return ("I'm " ^ (string_of_int age) ^ " years old.")

let hello =
  ask >>= fun name ->
  return ("hello, " ^ name ^ "!")

let bye =
  ask >>= fun name ->
  return ("bye, " ^ name ^ "!")

let show =
  get_name >>= fun name ->
  get_age >>= fun age ->
  return (name ^ ", " ^ age)

let convo =
  hello >>= fun a ->
  hello >>= fun b ->
  bye >>= fun c ->
  hello >>= fun d ->
  hello >>= fun e ->
  bye >>= fun f ->
  bye >>= fun g ->
  bye >>= fun h ->
  hello >>= fun i ->
  bye >>= fun j ->
  return (a :: b :: c :: d :: e :: f :: g :: h :: i :: j :: [])
