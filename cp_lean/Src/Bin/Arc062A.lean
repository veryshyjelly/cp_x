-- Created by Ayush Biswas at 2025/12/22 19:02
-- https://atcoder.jp/contests/abc046/tasks/arc062_a
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin
def solution : List (List ℕ) -> ℤ
| _ :: abcds =>
  if h₁ : ∀ cd, cd ∈ abcds → cd.length = 2 then
    match abcds with
    | ab :: cds =>
      have ⟨_, h_tail⟩ := List.forall_mem_cons.mp h₁
      let [a₀, b₀] := ab

      let (aₙ, bₙ) := cds.attach.foldl (λ (a, b) ⟨cd, h_cd_in_tail⟩ =>
        have : cd.length = 2 := h_tail cd h_cd_in_tail
        let [c, d] := cd
        let k := Nat.max ((a + c - 1) / c) ((b + d - 1) / d)
        (c * k, d * k)
      ) (a₀, b₀)

      aₙ + bₙ
    | [] => 0
  else 0
| [] => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
