-- Created by Ayush Biswas at 2026/01/15 14:20
-- https://atcoder.jp/contests/abc052/tasks/abc052_a
import Src.Cpio

-- @head begin
-- import Mathlib.Tactic
import Mathlib.Data.Int.Lemmas
-- import Mathlib.Data.List.Lemmas
-- import Mathlib.Data.String.Lemmas
-- @head end

-- @code begin

def solution : List (List ℕ) -> ℤ
| [[a, b, c, d]] => (a * b).max (c * d)
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
