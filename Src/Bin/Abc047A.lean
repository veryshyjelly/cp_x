-- Created by Ayush Biswas at 2025/12/22 21:51
-- https://atcoder.jp/contests/abc047/tasks/abc047_a
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin

def solution : List (List ℕ) -> String
| [abc] =>
  let (alice, bob) := abc.mergeSort.splitAt 2
  if alice.sum == bob.sum then "Yes" else "No"
| _ => "No"

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
