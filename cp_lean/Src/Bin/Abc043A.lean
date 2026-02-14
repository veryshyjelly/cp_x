-- Created by Ayush Biswas at 2025/12/20 12:14
-- https://atcoder.jp/contests/abc043/tasks/abc043_a
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin
def solution : List (List ℤ) -> ℤ
| [[n]] => n * (n + 1) / 2
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
