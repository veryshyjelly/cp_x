-- Created by Ayush Biswas at 2025/12/20 12:39
-- https://atcoder.jp/contests/abc043/tasks/arc059_a
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin

def cost (as : List ℤ) (b : ℤ) : ℤ :=
  as.map (λ x => (x - b)^2) |>.sum

def solution : List (List ℤ) -> ℤ
| [n] :: [as] =>
  let mean := as.sum / n
  [mean - 1, mean, mean + 1].map (cost as) |>.min?.getD 0
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
