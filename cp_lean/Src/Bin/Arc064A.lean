-- Created by Ayush Biswas at 2025/12/23 12:16
-- https://atcoder.jp/contests/abc048/tasks/arc064_a
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin
def eatCandies (lim ate : ℕ) : List ℕ -> ℕ
| a₁ :: a₂ :: as =>
  let diff := (a₁ + a₂) - lim
  eatCandies lim (ate + diff) ((a₂ - diff) :: as)
| _ => ate

def solution : List (List ℕ) -> ℤ
| [_n, x] :: [as] => eatCandies x 0 as
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
