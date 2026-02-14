-- Created by Ayush Biswas at 2025/12/30 19:05
-- https://atcoder.jp/contests/abc051/tasks/abc051_a
import Src.Cpio

-- @head begin
import Mathlib.Tactic
import Mathlib.Data.Int.Lemmas
import Mathlib.Data.List.Lemmas
import Mathlib.Data.String.Lemmas
-- @head end

-- @code begin

def solution : List String -> String
| [s] => " ".intercalate (s.splitOn ",")
| _ => ""

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
