-- Created by Ayush Biswas at 2025/12/20 16:07
-- https://atcoder.jp/contests/abc044/tasks/arc060_a
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin
def OFFSET := 2500
def WIDTH := 2 * OFFSET + 1

def getAllIndices (a b : ℕ) : List (ℕ×ℕ) :=
  List.range a |>.map (λ i => List.range b |>.map (λ j => (i, j))) |>.flatten

def update (ys : Array ℤ) (i sum : ℕ) (dp : Array (Array ℕ)) (h : i + 1 < dp.size) : Array (Array ℕ) :=
  let (yi, curr) := (ys[i]!, dp[i][sum]!)
  if curr = 0 then dp else
  let dp' := dp.set (i + 1) (dp[i + 1].set! sum (dp[i + 1][sum]! + curr))
  have h' : i + 1 < dp'.size := by
    simpa [dp'] using h
  let new_sum := yi + sum
  if 0 <= new_sum ∧ new_sum < WIDTH then
    let ns := new_sum.toNat
    dp'.set (i + 1) (dp'[i + 1].set! ns (dp'[i + 1][ns]! + curr))
  else dp

def solution : List (List ℤ) -> ℤ
| [n, target] :: [as] =>
  let n := n.toNat
  let a := as.toArray.map (λ x => x - target)
  let indices := getAllIndices n WIDTH
  let init := Array.replicate (n + 1) (Array.replicate WIDTH (0 : ℕ))
  let init := init.set! 0 (init[0]!.set! OFFSET 1)
  let dp := indices.foldl (λ acc (i, j) =>
    if h : i + 1 < acc.size then update a i j acc h else acc) init
  dp[n]![OFFSET]! - 1
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
