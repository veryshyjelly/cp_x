-- Created by Ayush Biswas at 2025/12/31 14:23
-- https://atcoder.jp/contests/abc051/tasks/abc051_d
import Src.Cpio

-- @head begin
import Mathlib.Data.Int.Lemmas
import Batteries.Data.BinomialHeap
-- @head end

-- @code begin
open Std

-- def g : Graph 3 := ⟨#[[(1, 1)], [(0, 1), (2, 1)], [(1, 1)]], by grind⟩
-- def d : Vector ℕ 3 := Vector.replicate 3 (10^9) |>.set 0 0
-- def pq : MinHeap := Batteries.mkBinomialHeap (ℕ×ℕ) (· <= ·) |>.insert (0, 0)

-- #eval dijstra g d pq

def MinHeap := Batteries.BinomialHeap (ℕ×ℕ) (· <= ·)
def Graph (n : ℕ) := { x : Array (List (ℕ×ℕ)) // x.size = n }

partial def dijstraIn {n : ℕ}
  (graph : Graph n) (dist : Vector ℕ n) (pq : MinHeap) : Vector ℕ n :=

  if pq.isEmpty then dist else

  let (d, u) := pq.head!
  let pq := pq.tail

  let (pq, dist) := if dist[u]! ≠ d
    then ⟨pq, dist⟩
    else graph.val[u]!.foldl (λ (pq, dist) (v, w) ↦
         if dist[v]! <= d + w then (pq, dist) else
         ⟨pq.insert (d + w, v), dist.set! v (d + w)⟩
        ) (pq, dist)

  dijstraIn graph dist pq

def dijstra {n : ℕ} (graph : Graph n) (start : ℕ) (h : start < n) : Vector ℕ n :=
  let arrayInit := Vector.replicate n (10^9) |>.set start 0
  let pqInit := Batteries.mkBinomialHeap (ℕ×ℕ) (· <= ·) |>.insert ((0, start))
  dijstraIn graph arrayInit pqInit

def dijstraEdges {n : ℕ}
  (graph : Graph n) (start : ℕ)
  (h : start < n) : HashSet (ℕ×ℕ) :=
  let dist := dijstra graph start h
  List.range n |>.attach.foldl (λ res ⟨u, hu⟩ ↦
    have h : u < graph.val.size := by
      have : u < n := by grind
      simpa [graph.property]
    (graph.val[u]'h).foldl (λ res (v, w) ↦
      if dist[u]! + w = dist[v]! then
        res |>.insert (u, v) |>.insert (v, u)
      else res
    ) res
  ) (HashSet.emptyWithCapacity n)

def solution : List (List ℕ) -> ℤ
| [n, m] :: edges =>
  have h₁ : ∀ edge ∈ edges, edge.length = 3 := given
  let graph : Graph n := edges.attach.foldl (λ ⟨g, h_g⟩ ⟨edge, h_in_edges⟩ => by
    have : edge.length = 3 := by grind
    let [a, b, c] := edge
    have h₂ : ∀ x ∈ [a, b], 1 <= x ∧ x <= n := given
    have : a - 1 < n ∧ b - 1 < n := by
      have : ∀ x ∈ [a, b], x - 1 < n := by grind
      simp [*]
    let g' := g.set (a - 1) ((b - 1, c) :: (g[a - 1]))
    have : g.size = g'.size := by grind
    let g'' := g'.set (b - 1) ((a - 1, c) :: (g'[b - 1]))
    exact ⟨g'', by grind⟩
   ) ⟨Array.replicate n [], by grind⟩

  let all_edges : HashSet (ℕ×ℕ) :=
  edges.attach.foldl (λ acc ⟨edge, h_in_edges⟩ =>
    have : edge.length = 3 := by grind
    let [a, b, _] := edge
    acc |>.insert (a, b) |>.insert (b, a)
  ) (HashSet.emptyWithCapacity (n^2))

  let used_edges : HashSet (ℕ×ℕ) :=
  List.range n |>.attach.foldl (λ acc ⟨i, h_i_range⟩ =>
    acc.union (dijstraEdges graph i (by grind))
  ) (HashSet.emptyWithCapacity (n^2))

  (all_edges.size - used_edges.size) / 2
| _ => 0

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
