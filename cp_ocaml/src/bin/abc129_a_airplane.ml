(* Created by Ayush Biswas at 2026/06/25 16:02
 https://atcoder.jp/contests/abc129/tasks/abc129_a *)
open Core

let sol a b c =
  let res = a + b + c - max a (max b c) in
  printf "%d" res
;;

let () = Scanf.scanf "%d %d %d" sol
