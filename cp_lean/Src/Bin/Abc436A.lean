-- Created by Ayush Biswas at 2025/12/15 12:30
-- https://atcoder.jp/contests/abc436/tasks/abc436_a
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin

def fillOs (s : String) : ℕ → String
  | 0     => s
  | n + 1   => fillOs ("o" ++ s) n

def solution : ℤ × List (List String) → String
| (n, s) => match s with
  | [[s]] => fillOs s (n - s.length).toNat
  | _ => ""

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
