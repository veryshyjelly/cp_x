-- Created by Ayush Biswas at 2025/12/23 11:21
-- https://atcoder.jp/contests/abc048/tasks/abc048_a
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin

def solution : List (List String) -> String
| [a, b, c] :: _ =>
  if a.length ≠ 0 ∧ b.length ≠ 0 ∧ c.length ≠ 0 then
    String.mk [a.get 0, b.get 0, c.get 0]
  else ""
| _ => ""

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
