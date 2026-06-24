(* Created by Ayush Biswas at 2026/06/24 09:22 *)
(* https://atcoder.jp/contests/abc127/tasks/abc127_e *)
open Core
open Lib

let n = 2 * Int.pow 10 5

let factorial =
  let f = Array.init n ~f:Fn.id in
  f.(0) <- 1;
  for i = 1 to n - 1 do
    f.(i) <- Mod.mul i f.(i - 1)
  done;
  f
;;

let nCr ~n ~r =
  Mod.mul (Mod.mul factorial.(n) @@ Mod.inv factorial.(r)) @@ Mod.inv factorial.(n - r)
;;

let sol n m k =
  let rows_sum =
    List.range 0 n
    |> List.sum (module Int) ~f:(fun d -> Mod.mul d (n - d))
    |> Mod.mul (Mod.mul m m)
  and col_sum =
    List.range 0 m
    |> List.sum (module Int) ~f:(fun d -> Mod.mul d (m - d))
    |> Mod.mul (Mod.mul n n)
  and rep_count = nCr ~n:((n * m) - 2) ~r:(k - 2) in
  let res = Mod.mul rep_count (Mod.add rows_sum col_sum) in
  printf "%d" res
;;

let () = Scanf.scanf "%d %d %d" sol
