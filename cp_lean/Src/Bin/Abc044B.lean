-- Created by Ayush Biswas at 2025/12/20 15:36
-- https://atcoder.jp/contests/abc044/tasks/abc044_b
import Src.Cpio

-- @head begin
import Std.Data.HashMap
import Mathlib.Data.Int.Basic
-- @head end
open Std

-- @code begin
def solution : List String -> String
| [w] =>
  let res := w.toList.mergeSort.groupByKey id |>.toList.all λ (_, g) => 2∣g.length
  if res then "Yes" else "No"
| _ => "No"

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
