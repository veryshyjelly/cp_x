(* Created by Ayush Biswas at 2026/06/25 14:03
https://atcoder.jp/contests/abc128/tasks/abc128_f *)
open Core

let sol n =
  let s = Array.init n ~f:(fun _ -> Scanf.scanf " %d" Fn.id)
  and res = ref 0 in
  for c = 1 to n - 1 do
    let cur = ref 0
    and k = ref 0 in
    while !k * c < n - 1 do
      cur := !cur + s.(n - 1 - (!k * c)) + s.(!k * c);
      incr k;
      if not ((n - 1) mod c = 0 && ((n - 1) / c) + 2 <= 2 * !k) then res := max !res !cur
    done
  done;
  printf "%d" !res
;;

let () = Scanf.scanf "%d" sol
