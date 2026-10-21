(* Created by Ayush Biswas at 2026/07/04 12:27 
   https://atcoder.jp/contests/abc129/tasks/abc129_f *)
open Core
open Lib

module type MOD = sig
  val add : int -> int -> int
  val mul : int -> int -> int
end

let matmul (module M : MOD) a b =
  let c = Array.make_matrix ~dimx:3 ~dimy:3 0 in
  for i = 0 to 2 do
    for j = 0 to 2 do
      for k = 0 to 2 do
        c.(i).(j) <- M.add c.(i).(j) (M.mul a.(i).(k) b.(k).(j))
      done
    done
  done;
  c
;;

let id = [| [| 1; 0; 0 |]; [| 0; 1; 0 |]; [| 0; 0; 1 |] |]

let binpow (module M : MOD) a n =
  let res = ref id in
  let a = ref a in
  let n = ref n in
  while !n > 0 do
    if !n land 1 = 1 then res := matmul (module M) !res !a;
    a := matmul (module M) !a !a;
    n := !n lsr 1
  done;
  !res
;;

let sol n a b m =
  let module M = Mod.Make (struct
      let mod_ = m
    end)
  in
  (* true powers of 10 *)
  let pow10 = Array.create ~len:19 1L in
  for i = 1 to 18 do
    pow10.(i) <- Int64.( * ) pow10.(i - 1) 10L
  done;
  let count_le (r : int64) =
    if Int64.(of_int a > r)
    then 0
    else Int.min n Int64.(to_int_exn (((r - of_int a) / of_int b) + 1L))
  in
  let mat d =
    let p = Int64.(to_int_exn (rem pow10.(d) (of_int m))) in
    [| [| p; 0; 0 |]; [| 1; 1; 0 |]; [| 0; b mod m; 1 |] |]
  in
  let final = ref id in
  for d = 1 to 18 do
    let cd =
      count_le (Int64.( - ) pow10.(d) 1L) - count_le (Int64.( - ) pow10.(d - 1) 1L)
    in
    if cd > 0 then final := matmul (module M) !final (binpow (module M) (mat d) cd)
  done;
  let ans = M.add (M.mul (a mod m) !final.(1).(0)) !final.(2).(0) in
  printf "%d\n" ans
;;

let () = Scanf.scanf "%d %d %d %d" sol
