(* Created by Ayush Biswas at 2026/06/27 11:40 
 https://atcoder.jp/contests/abc129/tasks/abc129_e *)
open Core
open Lib

let sol l =
  let open Char in
  let l = Bytes.of_string l in
  let n = Bytes.length l in
  let dp1 = Array.create ~len:(n + 1) 0
  and dp2 = Array.create ~len:(n + 1) 1 in
  for i = 1 to n do
    if Bytes.get l (i - 1) = '1'
    then (
      dp2.(i) <- Mod.mul 2 dp2.(i - 1);
      dp1.(i) <- Mod.add (Mod.mul 3 dp1.(i - 1)) dp2.(i - 1))
    else (
      dp2.(i) <- dp2.(i - 1);
      dp1.(i) <- Mod.mul 3 dp1.(i - 1))
  done;
  printf "%d" @@ Mod.add dp1.(n) dp2.(n)
;;

let () = Scanf.scanf "%s" sol
