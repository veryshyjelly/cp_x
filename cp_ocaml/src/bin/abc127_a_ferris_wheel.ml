(* Created by Ayush Biswas at 2026/06/23 16:05 *)
(* https://atcoder.jp/contests/abc127/tasks/abc127_a *)
open Core

let sol a b =
  let res = if a >= 13 then b else if a >= 6 then b / 2 else 0 in
  printf "%d" res
;;

let () = Scanf.scanf "%d %d" sol
