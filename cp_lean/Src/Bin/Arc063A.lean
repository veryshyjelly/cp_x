-- Created by Ayush Biswas at 2025/12/22 23:39
-- https://atcoder.jp/contests/abc047/tasks/arc063_a
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin

def countFlips (acc : ℕ): List Char -> ℕ
| a :: b :: ls =>
  if a == b then countFlips acc (b :: ls)
  else countFlips (acc + 1) (b :: ls)
| _ => acc

def solution : List String -> ℤ
| [s] => countFlips 0 s.toList
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
