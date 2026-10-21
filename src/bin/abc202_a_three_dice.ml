(* Created by Ayush Biswas at 2026/07/06 13:16 
   https://atcoder.jp/contests/abc202/tasks/abc202_a *)
open Core

let sol a b c =
  let res = 21 - (a + b + c) in
  printf "%d" res
;;

let () = Scanf.scanf "%d %d %d" sol
