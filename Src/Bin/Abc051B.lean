-- Created by Ayush Biswas at 2025/12/30 22:09
-- https://atcoder.jp/contests/abc051/tasks/abc051_b
import Src.Cpio

-- @head begin
import Mathlib.Tactic
import Mathlib.Data.Int.Lemmas
import Mathlib.Data.List.Lemmas
import Mathlib.Data.String.Lemmas
-- @head end

-- @code begin

def solution : List (List ℕ) -> ℤ
| [[k, s]] =>
  Array.range (k + 1) |>.map (λ x => Array.range (k + 1) |>.map (λ y =>
    let z := s - x - y
    if z + x + y = s ∧ z <= k then 1 else 0
  ) |>.sum ) |>.sum
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
