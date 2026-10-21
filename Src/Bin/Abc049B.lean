-- Created by Ayush Biswas at 2025/12/28 11:58
-- https://atcoder.jp/contests/abc049/tasks/abc049_b
import Src.Cpio

-- @head begin
import Mathlib.Tactic
import Mathlib.Data.Int.Lemmas
import Mathlib.Data.List.Lemmas
import Mathlib.Data.String.Lemmas
-- @head end

-- @code begin

def solution : List String -> CPio.ListOf String
| _ :: image => image.map (λ x => [x, x]) |>.flatten |> CPio.ListOf.LinesOf
| _ => CPio.ListOf.LinesOf []

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
