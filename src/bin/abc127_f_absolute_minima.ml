(* Created by Ayush Biswas at 2026/06/24 10:01
https://atcoder.jp/contests/abc127/tasks/abc127_f *)
open Core
open Lib

module MaxBase = CCHeap.Make (struct
    type t = int

    let leq a b = a >= b
  end)

module MaxH = Heap.Make (MaxBase)
module MinBase = CCHeap.Make_from_compare (Int)
module MinH = Heap.Make (MinBase)

type median =
  { low : MaxH.t
  ; high : MinH.t
  ; mutable sum_b : int
  }

let med = { low = MaxH.empty; high = MinH.empty; sum_b = 0 }

let rebalance () =
  if med.low.size > med.high.size + 1
  then MinH.push med.high @@ MaxH.pop med.low
  else if med.low.size < med.high.size
  then MaxH.push med.low @@ MinH.pop med.high
;;

let add a b =
  med.sum_b <- med.sum_b + b;
  if med.low.size = 0 || a <= MaxH.top_exn med.low
  then MaxH.push med.low a
  else MinH.push med.high a;
  rebalance ()
;;

let query () =
  match MaxH.top med.low with
  | None -> ()
  | Some m ->
    let res =
      (m * med.low.size) - med.low.sum + med.high.sum - (m * med.high.size) + med.sum_b
    in
    printf "%d %d\n" m res
;;

let () =
  let q = Scanf.scanf "%d" Fn.id in
  for i = 1 to q do
    match Scanf.scanf " %d" Fn.id with
    | 1 -> Scanf.scanf " %d %d" add
    | 2 -> query ()
    | _ -> assert false
  done
;;
