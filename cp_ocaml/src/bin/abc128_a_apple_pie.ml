(* Created by Ayush Biswas at 2026/06/24 18:12
https://atcoder.jp/contests/abc128/tasks/abc128_a *)
open Core

let sol a p =
  let total_pieces = (a * 3) + p in
  let total_pies = total_pieces / 2 in
  printf "%d" total_pies
;;

let () = Scanf.scanf "%d %d" sol
