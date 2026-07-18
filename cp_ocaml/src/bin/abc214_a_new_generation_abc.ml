(* Created by Ayush Biswas at 2026/07/06 13:12 
   https://atcoder.jp/contests/adt_all_20231205_1/tasks/abc214_a *)
open Core

let sol n =
  let num = if n <= 125 then 4 else if n <= 211 then 6 else 8 in
  printf "%d" num
;;

let () = Scanf.scanf "%d" sol
