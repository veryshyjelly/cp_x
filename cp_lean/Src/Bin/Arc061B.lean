-- Created by Ayush Biswas at 2025/12/21 18:22
-- https://atcoder.jp/contests/abc045/tasks/arc061_b
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
import Std.Data.HashSet
-- @head end

-- @code begin
open Std

structure Point where
  x : ℕ
  y : ℕ
deriving Hashable, BEq

def countInRect (rect : Point) (colored : HashSet Point) : ℕ :=
  let rect := List.range 3
    |>.map λ dx => List.range 3
    |>.map λ dy => Point.mk (rect.x + dx) (rect.y + dy)
  rect.flatten.filter (λ x => colored.contains x) |>.length

def getRange (x : ℕ) (lim : ℕ) : List ℕ :=
  let (startx, stopx) := (x - 2, (lim - 3).min x)
  List.range' startx (stopx - startx + 1)

def process
  (point : Point)
  (size : Point)
  (countColor : Array ℕ)
  (colored : HashSet Point)
  : (Array ℕ) × (HashSet Point) :=
  let x_range := getRange point.x size.x
  let y_range := getRange point.y size.y
  let newCount := x_range.map (λ x => y_range.map λ y => (x, y))
  |>.flatten.foldl (λ cnts (x, y) =>
      let this_cnt := countInRect (Point.mk x y) colored
      let cnts := cnts.set! this_cnt (cnts[this_cnt]! - 1)
      cnts.set! (this_cnt + 1) (cnts[this_cnt + 1]! + 1)
  ) countColor
  (newCount, colored.insert point)

def solution : List (List ℕ) -> CPio.ListOf ℤ
| [h, w, n] :: abs =>
  let size := Point.mk h w

  let (cnt, _) := abs.foldl (
    λ (cnt, colored) ab => match ab with
    | [a, b] => process (Point.mk (a - 1) (b - 1)) size cnt colored
    | _ => (cnt, colored)
  ) (Array.replicate 10 0, HashSet.emptyWithCapacity n)

  let zero_cnt := (h - 2) * (w - 2) - cnt.sum
  CPio.ListOf.LinesOf (cnt.set! 0 zero_cnt |>.toList.map Int.ofNat)

| _ => CPio.ListOf.LinesOf []

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
