-- Created by Ayush Biswas at 2025/12/30 16:14
-- https://atcoder.jp/contests/abc050/tasks/arc066_a
import Src.Cpio

-- @head begin
import Mathlib.Tactic
import Mathlib.Data.Int.Lemmas
import Mathlib.Data.List.Lemmas
import Mathlib.Data.String.Lemmas
-- @head end

-- @code begin

def solution : List (List ℕ) -> ℤ
| [n] :: [diffs] =>
  let actual_diffs := List.range n
    |>.map (λ (i : ℤ) => (n - 1 - 2 * i).natAbs)
    |>.mergeSort
  let diffs := diffs.mergeSort
  if actual_diffs ≠ diffs
  then 0 else (2 ^ (n / 2)) % (10^9+7)
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
