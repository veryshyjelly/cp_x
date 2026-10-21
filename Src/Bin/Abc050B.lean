-- Created by Ayush Biswas at 2025/12/30 12:02
-- https://atcoder.jp/contests/abc050/tasks/abc050_b
import Src.Cpio

-- @head begin
import Mathlib.Tactic
import Mathlib.Data.Int.Lemmas
import Mathlib.Data.List.Lemmas
import Mathlib.Data.String.Lemmas
-- @head end

-- @code begin

def solution : List (List ℕ) -> CPio.ListOf ℤ
| [n] :: times :: [m] :: drinks =>
  -- write assumptions about the input that are given
  have h₁ : times.length = n := given
  have h₂ : drinks.length = m := given
  have h₃ : ∀ drink ∈ drinks, drink.length = 2 := given
  let drinks : List (ℕ × ℕ) := drinks.attach.map (λ ⟨xy, h_in_drink⟩ =>
    (xy[0]'(by grind), xy[1]'(by grind)))
  let total_time := times.sum
  let res := drinks.attach.map (λ ⟨drink, h_drink_in_drinks⟩ =>
    have : 1 <= drink.fst ∧ drink.fst <= n := given
    total_time - times[drink.fst - 1] + drink.snd)
  CPio.ListOf.LinesOf res
| _ => CPio.ListOf.LinesOf []

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
