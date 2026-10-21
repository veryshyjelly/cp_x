-- Created by Ayush Biswas at 2025/12/21 11:50
-- https://atcoder.jp/contests/abc045/tasks/arc061_a
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Lemmas
import Mathlib.Data.List.Lemmas
import Mathlib.Data.String.Lemmas
-- @head end

-- @code begin
def Char.parse (c : Char) : ℕ := c.toNat - '0'.toNat

def compute (s : List Char) (h : s ≠ []) (comb : ℕ) : ℕ :=
  have h₁ : s.length ≠ 0 := by
    simp [h]

  let (total, curr, _) := s.drop 1
  |>.foldl (λ (total, curr, mask) si =>
    if mask &&& 1 = 1 then
      (total + curr, si.parse, mask>>>1)
    else
      (total, curr * 10 + si.parse, mask>>>1)
    ) (0, s[0].parse, comb)
  total + curr

def solution : List String -> ℤ
| [s] =>
  let h₁ : s.length ≠ 0 := given

  let n := s.length
  let chars := s.toList

  have h₂ : chars ≠ [] := by
    intro hs
    rw [String.length_eq_list_length] at h₁
    simp_all [chars]

  List.range (1 <<< (n - 1)) |>.map (compute chars h₂) |>.sum

| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
