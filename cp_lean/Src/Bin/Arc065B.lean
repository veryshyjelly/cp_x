-- Created by Ayush Biswas at 2025/12/29 13:10
-- https://atcoder.jp/contests/abc049/tasks/arc065_b
import Src.Cpio
import Src.Dsu

-- @head begin
import Std.Data.HashMap
import Mathlib.Tactic
import Mathlib.Data.Int.Lemmas
import Mathlib.Data.List.Lemmas
import Mathlib.Data.String.Lemmas
-- @head end

-- @code begin
open Std

def DsuN (n : ℕ) := { x : DSU // x.count = n }

def dsu_from_railroads
  (n : ℕ)
  (railroads : List (List ℕ))
  (h₁ : ∀ r ∈ railroads, r.length = 2)
  (h₂ : ∀ r ∈ railroads, ∀ node ∈ r, 1 <= node ∧ node <= n) : DsuN n :=
  railroads.attach.foldl (λ ⟨acc, hacc⟩ ⟨road, hr⟩ => by
    have h_road_len : road.length = 2 := h₁ road (by grind)
    have h_road_lim : ∀ node ∈ road, 1 <= node ∧ node <= n := h₂ road (by grind)
    let [a, b] := road
    have ha : ∀ x ∈ [a, b], x - 1 < n := by
      intro x hx
      specialize h_road_lim x
      simp [hx] at h_road_lim
      rcases h_road_lim with ⟨ha, han⟩
      have : x - 1 < x := by
        rw [← Nat.pred_eq_sub_one]
        exact Nat.pred_lt (by grind)
      linarith
    have h_ab_lt_acc_size : ∀ x ∈ [a - 1, b - 1], x < acc.count := by
      simp [hacc, ha]
    let acc := acc.union (a - 1) (b - 1)
      (by simp [h_ab_lt_acc_size])
      (by simp [h_ab_lt_acc_size])
    exact ⟨ acc, by grind [DSU.union_count] ⟩
  ) ⟨ DSU.new n, by grind [DSU.new_count] ⟩

def solution : List (List ℕ) -> CPio.ListOf ℤ
| [n, k, l] :: railroads =>
  have h₁ : ∀ path ∈ railroads, ∀ node ∈ path, 1 <= node ∧ node <= n := given
  have h₂ : ∀ path ∈ railroads, path.length = 2 := given

  let roads := railroads.take k
  let rails := railroads.drop k

  have h_road_rail {p : List ℕ -> Prop} (h : ∀ r ∈ railroads, p r) :
    (∀ road ∈ roads, p road) ∧ (∀ rail ∈ rails, p rail) := by
    constructor
    · intro r h_road
      · dsimp [roads] at h_road
        apply List.mem_of_mem_take at h_road
        exact h r h_road
    · intro r h_rail
      · dsimp [rails] at h_rail
        apply List.mem_of_mem_drop at h_rail
        exact h r h_rail

  let ⟨ dsu_roads, dsu_roads_len ⟩ := dsu_from_railroads n roads (h_road_rail h₂).left (h_road_rail h₁).left
  let ⟨ dsu_rails, dsu_rails_len ⟩ := dsu_from_railroads n rails (h_road_rail h₂).right (h_road_rail h₁).right

  let roots := (Array.range n).attach.map (λ ⟨x, hx⟩ =>
    (dsu_roads.root x (by grind), dsu_rails.root x (by grind))
  )
  let groups := roots.groupByKey id |>.map (λ k v => v.size)
  let res := roots.map (λ x => groups.get! x)

  CPio.ListOf.WordsOf res.toList

| _ => CPio.ListOf.WordsOf []

def main : IO Unit :=
  open CPio in
  solve { withConfig with splitter := Splitter.NoSplitting } solution

-- @code end
