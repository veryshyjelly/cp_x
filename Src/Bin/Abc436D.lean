-- Created by Ayush Biswas at 2025/12/16 22:08
-- https://atcoder.jp/contests/abc436/tasks/abc436_d
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Basic
-- @head end

-- @code begin
open Std

abbrev Loc := ℕ×ℕ

def getIdx? (boundary : Loc) : Loc -> Option ℕ
  | (x, y) => match boundary with | (n, m) => if x < n ∧ y < m then (x * m) + y else none

def findObstacles (grid : Array Char) : Array ℕ :=
  grid.mapIdx (λ i cell => (cell, i))
    |>.filter (λ (cell, _) => cell = '#')
    |>.map λ (_, loc) => loc

def findWarps (grid : Array Char) : Array (List ℕ) :=
  let warps := Array.replicate 128 []
  grid.mapIdx (λ i c => (i, c))
      |>.foldl (λ (acc : Array (List ℕ)) (p : ℕ × Char) =>
        let (i, c) := p
        if c.isAlpha then
          let code := c.toNat
          if h : code < acc.size then
            let existing := acc[code]
            acc.set code (i :: existing)
          else acc
        else acc
      ) warps

def getNeighbors
  (loc : ℕ)
  (visited : Array Bool)
  (grid : Array Char)
  (boundary : Loc)
  (warps : Array (List ℕ))
   : (Array (List ℕ) × List ℕ) :=
  let (_, m) := boundary
  let (x, y) := (loc/m, loc%m)
  if let some cell := grid[loc]? then
      let neighs := [(x - 1, y), (x, y - 1), (x + 1, y), (x, y + 1)].map (getIdx? boundary) |>.filterMap (·)
      let teleports := warps.getD cell.toNat []
      let warps := warps.set! cell.toNat []
      let finalNeighbors := (neighs ++ teleports).filter (not visited[·]!) |> HashSet.ofList |>.toList
      (warps, finalNeighbors)
  else (warps, [])

partial def bfs
  (grid : Array Char)
  (boundary : Loc)
  (warps : Array (List ℕ))
  (visited : Array Bool)
  (queue : Queue (ℤ×ℕ))
  : ℤ := match queue.dequeue? with
  | some ((step, loc), queue) => if (loc + 1) == grid.size then step
    else
    let (warps, neighbors) := getNeighbors loc visited grid boundary warps
    let visited := neighbors.foldl (λ v x => v.set! x true) visited
    let queue := queue.enqueueAll (neighbors.map (λ loc => (step + 1, loc)))
    bfs grid boundary warps visited queue
  | none => -1

def solution : List String → ℤ
| h :: t =>
  match h.splitOn " " |>.map (·.toNat!) with
    | [h, w] =>
    let grid := t.map String.toList |>.flatten |>.toArray
    let warps := findWarps grid
    let obstacles := findObstacles grid
    let visited : Array Bool := obstacles.foldl (λ v i => v.set! i true) (Array.replicate (h * w) false)
    bfs grid (h, w) warps visited (Queue.empty.enqueue (0, 0))
    | _ => 0
| [] => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
