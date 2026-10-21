-- Created by Ayush Biswas at 2025/12/20 17:51
-- https://atcoder.jp/contests/abc044/tasks/arc060_b
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
import Mathlib.Data.Nat.Sqrt
-- @head end

-- @code begin
partial def f_inn (b n acc : ℕ) : ℕ :=
  if n < b then acc + n
  else f_inn b (n / b) (acc + (n % b))

def f (b n : ℕ) : ℕ := f_inn b n 0

def solution : List (List ℤ) -> ℤ
| [n] :: [s] :: _ =>
  let (n, s) := (n.toNat, s.toNat)
  if s > n then -1
  else if s = n then n + 1
  else
    let uptoRoot := List.range' 1 n.sqrt
    let candidates := uptoRoot ++ uptoRoot.map (λ p =>
      if ¬p∣(n - s) then 0
      else ((n - s) / p + 1)
    )
    candidates
    |>.filter (λ k => k > 1)
    |>.mergeSort
    |>.find? (λ k => f k n = s)
    |>.map Int.ofNat
    |>.getD (-1)
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution
-- @code end
