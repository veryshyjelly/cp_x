-- Created by Ayush Biswas at 2025/12/23 11:07
-- https://atcoder.jp/contests/abc047/tasks/arc063_b
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin

def solution : List (List ℕ) -> ℤ
| [_n, _t] :: [prices] =>
  let (_, profits) := prices.foldl (λ (minₚ, acc) pi =>
    let minₚ := minₚ.min pi
    (minₚ, (pi - minₚ) :: acc)
  ) (10^9, [])
  let maxProfit := profits.max?.getD 0
  profits.filter (· = maxProfit) |>.length
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
