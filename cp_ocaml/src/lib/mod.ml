let mod_ = 1000000007

let add a b =
  let x = a + b in
  if x >= mod_ then x - mod_ else x
;;

let sub a b =
  let x = a - b in
  if x < 0 then x + mod_ else x
;;

let mul a b = a * b mod mod_

let rec pow a n =
  if n = 0
  then 1
  else if n land 1 = 0
  then (
    let x = pow a (n lsr 1) in
    mul x x)
  else mul a (pow a (n - 1))
;;

let inv a = pow a (mod_ - 2)
