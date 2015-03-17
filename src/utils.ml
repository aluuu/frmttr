let may : type a b. b -> (a -> b) -> a option -> b = fun n f m ->
  match n, f, m with
  | n, _, None -> n
  | _, f, (Some x) -> f x

let prefixp str inp =
  if String.length str <= String.length inp &&
     str = String.sub inp 0 (String.length str)
  then
    Some (String.sub inp (String.length str) (String.length inp - String.length str))
  else
    None

let read_int inp =
  let n = String.length inp in
  let rec loop acc i =
    if i >= n then Some (acc, "") else
      let c = inp.[i] in
      if c >= '0' && c <= '9' then
        loop (acc * 10 + (int_of_char c - int_of_char '0')) (succ i)
      else if i = 0 then
        None
      else
        Some (acc, String.sub inp i (n-i)) in
  if n = 0 then
    None
  else
    loop 0 0

let read_float inp =
  let n = String.length inp in
  let rec loop acc i =
    if i >= n then Some (float_of_string acc, "") else
      let c = inp.[i] in
      if (c == '-' && i == 0) || (c >= '0' && c <= '9' || c == '.') then
        loop (String.concat "" [acc; Char.escaped c]) (succ i)
      else if i = 0 then
        None
      else
        Some (float_of_string acc, String.sub inp i (n-i)) in
  if n = 0 then
    None
  else
    loop "" 0

let read_string_until inp final_c =
  let n = String.length inp in
  let rec loop acc i =
    if i >= n then Some (acc, "") else
      let c = inp.[i] in
      if (c == final_c) then
        Some (acc, String.sub inp i (n-i))
      else if i = 0 then
        None
      else
        loop (String.concat "" [acc; Char.escaped c]) (succ i) in
  if n = 0 then
    None
  else
    loop "" 0
