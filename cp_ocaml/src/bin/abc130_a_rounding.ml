(* Created by Ayush Biswas at 2026/07/04 22:13 
   https://atcoder.jp/contests/abc130/tasks/abc130_a *)
open Core

let sol x a =
  let res = if x < a then 0 else 10 in
  printf "%d" res
;;

let () = Scanf.scanf "%d %d" sol
