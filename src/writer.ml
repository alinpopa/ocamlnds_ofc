type ('a, 'w) writer = Writer of ('a * 'w list)

let run_writer w =
  match w with
  | Writer (a, w) -> (a, w)

let return a =
  Writer (a, [])

let (>>=) w f =
  match w with
  | Writer (a, w) ->
      let (a', w') = run_writer (f a) in
      Writer (a', w @ w')

let tell s =
  Writer ((), s)
