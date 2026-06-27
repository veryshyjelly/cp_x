(* Created by Ayush Biswas at 2026/06/25 17:29
 https://atcoder.jp/contests/abc129/tasks/abc129_c *)
open Core
open Lib

let sol n m =
  let a = Array.create ~len:(n + 1) 1 in
  for _ = 1 to m do
    Scanf.scanf " %d" (fun ai -> a.(ai) <- 0)
  done;
  a.(1) <- a.(1) * a.(0);
  for i = 2 to n do
    a.(i) <- a.(i) * Mod.add a.(i - 1) a.(i - 2)
  done;
  printf "%d" a.(n)
;;

let () = Scanf.scanf "%d %d" sol
