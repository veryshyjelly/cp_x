(* Created by Ayush Biswas at 2026/06/24 20:50
https://atcoder.jp/contests/abc128/tasks/abc128_d *)
open Core

let prefix_sum ~arr =
  let n = Array.length arr in
  let res = Array.create ~len:(n + 1) 0 in
  for i = 1 to n do
    res.(i) <- res.(i - 1) + arr.(i - 1)
  done;
  res
;;

let sol n k =
  let d = Array.init n ~f:(fun _ -> Scanf.scanf " %d" Fn.id)
  and r = min n k in
  let front_prefix = prefix_sum ~arr:d
  and back_prefix = prefix_sum ~arr:(Array.rev d)
  and max_hand = ref 0 in
  for a = 0 to r do
    for b = 0 to r do
      if a + b <= r
      then (
        let a' = if a = 0 then Array.create ~len:0 0 else Array.slice d 0 a
        and b' = Array.slice d (n - b) n in
        let c = Array.append a' b' |> Array.filter ~f:Int.is_negative in
        Array.sort c ~compare:Int.compare;
        let neg_res =
          List.take (Array.to_list c) (k - a - b) |> List.sum (module Int) ~f:Fn.id
        and pos_res = front_prefix.(a) + back_prefix.(b) in
        max_hand := max !max_hand (abs neg_res + pos_res))
    done
  done;
  printf "%d" !max_hand
;;

let () = Scanf.scanf "%d %d" sol
