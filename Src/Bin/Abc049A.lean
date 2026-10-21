-- Created by Ayush Biswas at 2025/12/28 11:25
-- https://atcoder.jp/contests/abc049/tasks/abc049_a
import Src.Cpio

-- @head begin
import Mathlib.Tactic
import Mathlib.Data.Int.Lemmas
import Mathlib.Data.List.Lemmas
import Mathlib.Data.String.Lemmas
-- @head end

-- @code begin

def solution : List String -> String
| [s] => have h : s.length = 1 := given
  have h₂ : s.data.length ≠ 0 := by
    rw [← String.length_eq_list_length]
    linarith
  let c := s.data[0]
  if "aeiou".contains c then "vowel" else "consonant"
| _ => ""

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
