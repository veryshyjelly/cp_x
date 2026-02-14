-- Created by Ayush Biswas at 2026/01/16 19:57
-- https://atcoder.jp/contests/abc052/tasks/abc052_b
import Src.Cpio

-- @head begin
import Mathlib.Tactic
import Mathlib.Data.Int.Lemmas
import Mathlib.Data.List.Lemmas
import Mathlib.Data.String.Lemmas
-- @head end

-- @code begin
def Int.max (a b : ℤ) : ℤ :=
  if a > b then a else b

def solution : List String -> ℤ
| [n, s] => s.foldl (λ (acc, res) c ↦
    let acc := if c = 'I' then acc + 1 else acc - 1
    let res := res.max acc
    (acc, res)
  ) (0, 0) |>.snd
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
