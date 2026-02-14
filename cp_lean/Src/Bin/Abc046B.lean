-- Created by Ayush Biswas at 2025/12/22 18:49
-- https://atcoder.jp/contests/abc046/tasks/abc046_b
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin

def solution : List (List ℕ) -> ℤ
| [n, k] :: _ => k * (k - 1) ^ (n - 1)
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
