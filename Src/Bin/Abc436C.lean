-- Created by Ayush Biswas at 2025/12/16 13:52
-- https://atcoder.jp/contests/abc436/tasks/abc436_c
import Src.Cpio

-- @head begin
import Std.Data.HashSet
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin
open Std

def getCube : (ℤ × ℤ) -> List (ℤ × ℤ)
  | (a, b) => [(a, b), (a + 1, b), (a, b + 1), (a + 1, b + 1)]

def fillCube (acc : HashSet (ℤ × ℤ) × ℤ) :
  List ℤ -> HashSet (ℤ × ℤ) × ℤ
  | [r, c] =>
  match acc with
    | (space, count) =>
    let cells := getCube (r, c)
    if cells.any (space.contains ·) then
      acc
    else
      (space.insertMany cells, count + 1)
  | _ => acc

def solution : List (List ℤ) → ℤ
| [_, m] :: rcs =>
  let filled : HashSet (ℤ × ℤ) := HashSet.emptyWithCapacity (4 * m.toNat)
  let (_, res) := rcs.foldl fillCube (filled, 0)
  res
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
