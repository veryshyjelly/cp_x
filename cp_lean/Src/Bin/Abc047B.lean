-- Created by Ayush Biswas at 2025/12/22 22:33
-- https://atcoder.jp/contests/abc047/tasks/abc047_b
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin
structure Point where
  x : ℕ
  y : ℕ

def Point.mapx (f : ℕ -> ℕ) : Point -> Point
| {x, y} => { x := f x , y := y}

def Point.mapy (f : ℕ -> ℕ) : Point -> Point
| {x, y} => { x := x, y := f y}

structure Rectangle where
  min : Point
  max : Point

def Rectangle.mapx (f : ℕ -> ℕ) : Rectangle -> Rectangle
| {min, max} => {min := min.mapx f, max := max.mapx f}

def Rectangle.mapy (f : ℕ -> ℕ) : Rectangle -> Rectangle
| {min, max} => {min := min.mapy f, max := max.mapy f}

def Rectangle.area : Rectangle -> ℕ
| {min, max} => (max.y - min.y) * (max.x - min.x)

def solution :  List (List ℕ) -> ℤ
| [w, h, _] :: xyas =>
  let rect := xyas.foldl (λ r xya =>
    match xya with
    | [xi, yi, a] =>
      match a with
      | 1 => r.mapx λ x => x.max xi
      | 2 => r.mapx λ x => x.min xi
      | 3 => r.mapy λ y => y.max yi
      | 4 => r.mapy λ y => y.min yi
      | _ => r
    | _ => r
  ) (Rectangle.mk (Point.mk 0 0) (Point.mk w h))
  rect.area
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
