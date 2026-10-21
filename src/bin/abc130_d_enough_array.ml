(* Created by Ayush Biswas at 2026/07/05 09:47 
   https://atcoder.jp/contests/abc130/tasks/abc130_d *)
open Core

let sol n k =
  let a = Array.init n ~f:(fun _ -> Scanf.scanf " %d" Fn.id) in
  let res, sum, j = ref 0, ref 0, ref 0 in
  for i = 0 to n - 1 do
    while !sum < k && !j < n do
      sum := !sum + a.(!j);
      incr j
    done;
    if !sum >= k then res := !res + (n - !j + 1);
    sum := !sum - a.(i)
  done;
  printf "%d" !res
;;

let () = Scanf.scanf "%d %d" sol
