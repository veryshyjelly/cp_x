-- @head begin
import Mathlib.Tactic
-- @head end

-- @code begin

structure DSU where
  count : ℕ
  sizes : Array ℕ
  parent : Array ℕ
  parent_size : parent.size = count
  parent_idx : ∀ p ∈ parent, p < count
  sizes_size : sizes.size = count

namespace DSU

def new (count : ℕ) : DSU := by
  let parent := Array.range count
  let sizes := Array.replicate count 1

  have h₂ : ∀ x ∈ parent, x < count := by
    intro x hx
    dsimp [parent] at hx
    exact Array.mem_range.mp hx

  exact DSU.mk count sizes parent Array.size_range h₂ Array.size_replicate

theorem new_count (n : ℕ) : (new n).count = n := by
  rw [new]

def rootAux (a : ℕ) (self : DSU) (h : a < self.count) : ℕ -> ℕ
| 0 => a
| fuel + 1 => by
  have h₁ : a < self.parent.size := by
    rw [self.parent_size]
    exact h

  let pₐ := self.parent[a]

  have hpa_idx : pₐ < self.count := by
    have h₂ : pₐ ∈ self.parent := Array.getElem_mem h₁
    exact self.parent_idx pₐ h₂

  by_cases hEq : pₐ = a
  · exact a
  · exact rootAux pₐ self hpa_idx fuel

def root (a : ℕ) (self : DSU) (h : a < self.count) : ℕ :=
  rootAux a self h self.count

theorem rootAux_lt_count
  (a : ℕ) (self : DSU) (h : a < self.count) (fuel : ℕ) :
  rootAux a self h fuel < self.count := by
  induction fuel generalizing a with
  | zero =>
    rw [rootAux]
    exact h
  | succ fuel ih =>
    rw [rootAux]
    split
    · simp [h]
    · apply ih

theorem root_lt_count
  (a : ℕ) (self : DSU) (h : a < self.count) :
  root a self h < self.count := by
  rw [root]
  apply rootAux_lt_count

def unionAux
  (a b : ℕ)
  (self : DSU)
  (ha : a < self.count)
  (hb : b < self.count) : DSU := by
  have h₁ : a < self.sizes.size := by simp [self.sizes_size, ha]
  have h₂ : b < self.sizes.size := by simp [self.sizes_size, hb]
  have h₃ : b < self.parent.size := by simp [self.parent_size, hb]

  let sizes := self.sizes.set a (self.sizes[a] + self.sizes[b])
  let parent := self.parent.set b a

  have hs : sizes.size = self.count := by
    rw [Array.size_set, ← self.sizes_size]

  have hp : parent.size = self.count := by
    rw [Array.size_set, ← self.parent_size]

  have hpidx : ∀ x ∈ parent, x < self.count := by
    simp [parent]
    rw [Array.forall_getElem.symm]
    intro j hj
    rw [Array.getElem_set]
    split
    · exact ha
    · simp [self.parent_idx]

  exact mk self.count sizes parent hp hpidx hs

theorem union_aux_count {a b : ℕ}
  (self : DSU) (ha : a < self.count) (hb : b < self.count) :
  (self.unionAux a b ha hb).count = self.count := by
  rw [unionAux]

def union
  (a b : ℕ)
  (self : DSU)
  (ha : a < self.count)
  (hb : b < self.count)
  : DSU := by
  let a' := self.root a ha
  let b' := self.root b hb
  have ha : a' < self.count := by apply root_lt_count
  have hb : b' < self.count := by apply root_lt_count
  let size'a := self.sizes[a']'(by simp [self.sizes_size, ha])
  let size'b := self.sizes[b']'(by simp [self.sizes_size, hb])

  by_cases hab : a' = b'
  · exact self
  · by_cases hsz : size'a < size'b
    · exact self.unionAux b' a' hb ha
    · exact self.unionAux a' b' ha hb

theorem union_count {a b : ℕ}
  (self : DSU) (ha : a < self.count) (hb : b < self.count) :
  (self.union a b ha hb).count = self.count := by
  rw [union]
  split
  · rfl
  · split
    · simp [union_aux_count]
    · simp [union_aux_count]

end DSU

-- @code end
