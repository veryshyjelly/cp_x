-- Created by Ayush Biswas at 2025/12/19 11:21
-- https://atcoder.jp/contests/abc042/tasks/arc058_b
import Src.Cpio

-- @head begin
import Mathlib.Data.ZMod.Basic
-- @head end

-- @code begin
def MOD := 10^9 + 7
abbrev 𝔽 := ZMod MOD
def size := 2 * 10^5

@[irreducible]
def factorials : Array 𝔽 :=
  let res := Array.emptyWithCapacity size
  let zeroFact : 𝔽 := 1
  let (_, res) := List.range' 1 (size-1) |>.foldl (λ (fac, acc) i =>
    let fac := fac * i
    (fac, acc.push fac)
  ) (zeroFact, res.push zeroFact)
  res

def numWays (x y : ℕ) : 𝔽 :=
  if h₁ : x + y < factorials.size then
    factorials[x + y] * factorials[x].inv * factorials[y].inv
  else 1

def solution : List (List ℕ) → ℤ
| [h, w, a, b] :: _ =>
  let r := List.range' b (w - b)
    |>.map (λ i => numWays (h - a - 1) i * numWays (a - 1) (w - i - 1))
    |>.sum
  r.val
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
