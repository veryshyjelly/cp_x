(* Created by Ayush Biswas at 2026/06/25 16:10
 https://atcoder.jp/contests/abc129/tasks/abc129_b *)
open Core

let prefix_sum arr n =
  let res = Array.create ~len:(n + 1) 0 in
  for i = 0 to n - 1 do
    res.(i + 1) <- res.(i) + arr.(i)
  done;
  res
;;

let sol n =
  let w = Array.init n ~f:(fun _ -> Scanf.scanf " %d" Fn.id) in
  let front_prefix = prefix_sum w n
  and back_prefix = prefix_sum (Array.rev w) n
  and res = ref Int.max_value in
  for i = 1 to n - 1 do
    let j = n - i in
    let diff = abs (front_prefix.(i) - back_prefix.(j)) in
    res := min !res diff
  done;
  printf "%d" !res
;;

let () = Scanf.scanf "%d" sol
