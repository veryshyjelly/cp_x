-- Created by Ayush Biswas at 2025/12/23 12:39
-- https://atcoder.jp/contests/abc048/tasks/arc064_b
import Src.Cpio

-- @head begin
import Mathlib.Tactic
import Mathlib.Data.Int.Lemmas
import Mathlib.Data.List.Lemmas
import Mathlib.Data.String.Lemmas
-- @head end

-- @code begin

def solution : List String -> String
| [s] =>
  let h₁ : s.length >= 3 := given -- given
  let s' := s.toList

  have : s' ≠ [] := by
    intro hs -- hs : s' = []
    simp [s'] at hs -- hs : s.data = []
    rw [String.length_eq_list_length] at h₁ -- h₁ : s.data.length >= 3
    rw [← List.length_eq_zero_iff] at hs -- hs : s.data.length = 0
    linarith

  have : 0 < s'.length := by
    rw [List.length_pos_iff]
    exact ‹s' ≠ []›
    -- exact h₂

  if xor (s'[0] = s'.getLast ‹s' ≠ []›) (2∣s.length)
  then "Second"
  else "First"
| _ => ""

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
