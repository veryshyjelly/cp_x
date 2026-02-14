-- Created by Ayush Biswas at 2025/12/20 15:29
-- https://atcoder.jp/contests/abc044/tasks/abc044_a
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin
def solution : List (List ℤ) -> ℤ
| [n] :: [k] :: [x] :: [y] :: _ => x * (min n k) + y * (max (n - k) 0)
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
