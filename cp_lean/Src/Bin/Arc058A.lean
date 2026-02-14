-- Created by Ayush Biswas at 2025/12/18 21:56
-- https://atcoder.jp/contests/abc042/tasks/arc058_a
import Src.Cpio

-- @head begin
import Std.Data.HashSet
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin
open Std

partial def digits (acc : HashSet ℕ) : ℕ -> HashSet ℕ
| 0 => acc
| n =>  digits (acc.insert (n%10)) (n/10)

def solution : List (List ℤ) → ℤ
| [n, _k] :: [ds] =>
  let n := n.toNat
  let barred := HashSet.emptyWithCapacity.insertMany ds
  List.range' n (10*n) |>.find? (λ x =>
    let dig := digits (HashSet.emptyWithCapacity) x
    dig.all (barred.contains · |>.not)
  ) |>.getD 0
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
