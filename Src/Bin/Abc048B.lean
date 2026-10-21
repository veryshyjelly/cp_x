-- Created by Ayush Biswas at 2025/12/23 11:42
-- https://atcoder.jp/contests/abc048/tasks/abc048_b
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin
def multipleTillN (x : ℤ) : ℤ -> ℤ
| -1 => 0
| n => n / x + 1

def solution : List (List ℤ) -> ℤ
| [a, b, x] :: _ => multipleTillN x b - multipleTillN x (a - 1)
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
