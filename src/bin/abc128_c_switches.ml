(* Created by Ayush Biswas at 2026/06/24 18:49
https://atcoder.jp/contests/abc128/tasks/abc128_c *)
open Core

let read_bulb () =
  let k = Scanf.scanf " %d" Fn.id
  and bulb = ref 0 in
  for i = 1 to k do
    let si = Scanf.scanf " %d" Fn.id in
    bulb := !bulb lor (1 lsl (si - 1))
  done;
  !bulb
;;

let check_combination b ~bulbs ~parities =
  Array.for_all2_exn bulbs parities ~f:(fun bulb parity ->
    Int.popcount (b land bulb) % 2 = parity)
;;

let sol n m =
  let bulbs = Array.init m ~f:(fun _ -> read_bulb ())
  and parities = Array.init m ~f:(fun _ -> Scanf.scanf " %d" Fn.id) in
  let res =
    List.range 0 (1 lsl n) |> List.count ~f:(check_combination ~bulbs ~parities)
  in
  printf "%d" res
;;

let () = Scanf.scanf "%d %d" sol
