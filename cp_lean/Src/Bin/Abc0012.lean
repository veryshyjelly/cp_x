-- Created by Ayush Biswas at 2025/12/18 18:37
-- https://atcoder.jp/contests/abc001/tasks/abc001_2
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin

def solution : List (List ℤ) -> String
| [[m]] => let k := Float.ofInt m / 1000
  let vv := if k < 0.1 then 0
  else if k <= 5 then k * 10
  else if k <= 30 then k + 50
  else if k <= 70 then (k - 30) / 5 + 80
  else 89
  let s := toString vv.toInt64.toInt
  List.replicate (2 - s.length) "0" |> String.join |>.append s
| _ => ""

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
