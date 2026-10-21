(* Created by Ayush Biswas at 2026/06/25 19:59
 https://atcoder.jp/contests/abc129/tasks/abc129_d *)
open Core

let sol h w =
  let g = Array.init h ~f:(fun _ -> Scanf.scanf " %s" Bytes.of_string) in
  let ok r c = Char.( <> ) (Bytes.get g.(r) c) '#' in
  let mk () = Array.make_matrix ~dimx:w ~dimy:h 0 in
  let l, r, u, d = mk (), mk (), mk (), mk () in
  for i = 0 to h - 1 do
    for j = 0 to w - 1 do
      if ok i j then l.(j).(i) <- (if j > 0 then l.(j - 1).(i) else 0) + 1
    done;
    for j = w - 1 downto 0 do
      if ok i j then r.(j).(i) <- (if j < w - 1 then r.(j + 1).(i) else 0) + 1
    done
  done;
  for j = 0 to w - 1 do
    for i = 0 to h - 1 do
      if ok i j then u.(j).(i) <- (if i > 0 then u.(j).(i - 1) else 0) + 1
    done;
    for i = h - 1 downto 0 do
      if ok i j then d.(j).(i) <- (if i < h - 1 then d.(j).(i + 1) else 0) + 1
    done
  done;
  let ans = ref 0 in
  for i = 0 to w - 1 do
    for j = 0 to h - 1 do
      ans := max !ans (l.(i).(j) + r.(i).(j) + u.(i).(j) + d.(i).(j) - 3)
    done
  done;
  printf "%d" !ans
;;

let () = Scanf.scanf "%d %d" sol
