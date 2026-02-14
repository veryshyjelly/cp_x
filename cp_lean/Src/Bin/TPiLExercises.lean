variable (p q r : Prop)

-- commutativity of ∧ and ∨
example : p ∧ q ↔ q ∧ p :=
  Iff.intro (fun h => ⟨ h.right, h.left ⟩) (fun h => ⟨ h.right, h.left ⟩)

example : p ∨ q ↔ q ∨ p :=
  Iff.intro (fun h => h.elim (λ hp => Or.inr hp) (λ hq => Or.inl hq))
    (fun h => h.elim (λ hq => Or.inr hq) (λ hp => Or.inl hp))

-- associativity of ∧ and ∨
example : (p ∧ q) ∧ r ↔ p ∧ (q ∧ r) := Iff.intro
  (fun h => ⟨h.left.left, h.left.right, h.right⟩)
  (fun h => ⟨ ⟨ h.left, h.right.left ⟩, h.right.right ⟩)

example : (p ∨ q) ∨ r ↔ p ∨ (q ∨ r) := Iff.intro
  (fun h => h.elim (λ hpq => hpq.elim (λ hp => Or.inl hp) (λ hq => Or.inr (Or.inl hq)))
                   (λ hr => Or.inr (Or.inr hr)))
  (fun h => h.elim (λ hp => Or.inl (Or.inl hp))
                   (λ hqr => hqr.elim (λ hq => Or.inl (Or.inr hq)) (λ hr => Or.inr hr)))

-- distributivity
example : p ∧ (q ∨ r) ↔ (p ∧ q) ∨ (p ∧ r) := Iff.intro
  (fun h =>
    have hp := h.left
    h.right.elim (λ hq => Or.inl ⟨hp, hq⟩) (λ hr => Or.inr ⟨hp, hr⟩))
  (fun h => h.elim (λ hpq => ⟨hpq.left, Or.inl hpq.right⟩)
                   (λ hpr => ⟨hpr.left, Or.inr hpr.right⟩))

example : p ∨ (q ∧ r) ↔ (p ∨ q) ∧ (p ∨ r) := Iff.intro
  (fun h => h.elim (λ hp => ⟨Or.inl hp, Or.inl hp⟩)
                   (λ hqr => ⟨Or.inr hqr.left, Or.inr hqr.right⟩))
  (fun h => h.left.elim
    (λ hp => Or.inl hp)
    (λ hq => h.right.elim (λ hp => Or.inl hp)
                          (λ hr => Or.inr ⟨hq, hr⟩)))

-- other properties
example : (p → (q → r)) ↔ (p ∧ q → r) := Iff.intro
  (fun h => (λ hpq : p ∧ q => h hpq.left hpq.right))
  (fun h => (λ hp : p => (λ hq : q => h ⟨hp, hq⟩)))

example : ((p ∨ q) → r) ↔ (p → r) ∧ (q → r) := Iff.intro
  (fun h => ⟨(λ hp => h (Or.inl hp)), (λ hq => h (Or.inr hq))⟩)
  (fun h => (λ hpq : (p ∨ q) =>
    hpq.elim (λ hp => h.left hp) (λ hq => h.right hq)))

example : ¬(p ∨ q) ↔ ¬p ∧ ¬q := Iff.intro
  (fun h =>
    have hnp : ¬p := (λ hp => h (Or.inl hp))
    have hnq : ¬q := (λ hq => h (Or.inr hq))
    ⟨hnp, hnq⟩)
  (fun h => (λ hpq => hpq.elim
              (λ hp => h.left hp)
              (λ hq => h.right hq)))

example : ¬p ∨ ¬q → ¬(p ∧ q) :=
  fun hnpq =>
  λ hpq => hnpq.elim
    (λ hnp => absurd hpq.left hnp)
    (λ hnq => absurd hpq.right hnq)

example : ¬(p ∧ ¬p) := fun h => absurd h.left h.right

example : p ∧ ¬q → ¬(p → q) :=
  fun hpnq : p ∧ ¬q =>
  λ hpiq : p → q =>
  have hq := hpiq hpnq.left
  absurd hq hpnq.right

example : ¬p → (p → q) :=
  fun hnp hp => absurd hp hnp

example : (¬p ∨ q) → (p → q) :=
  fun hnpoq =>
  fun hp =>
  show q from hnpoq.elim (absurd hp ·) id

example : p ∨ False ↔ p := Iff.intro
  (fun hpf => hpf.elim id (λ f => f.elim))
  (fun hp => Or.inl hp)

example : p ∧ False ↔ False := Iff.intro
  (fun h => h.right)
  (fun h => h.elim)

example : (p → q) → (¬q → ¬p) :=
  fun hpiq hnq hp =>
  absurd (hpiq hp) hnq

open Classical

variable (α : Type) (p q : α → Prop)
variable (r : Prop)

example : (∃ _x : α, r) → r :=
  fun ⟨_w, hw⟩ => hw

example (a : α) : r → (∃ _x : α, r) :=
  fun hr => ⟨ a, hr ⟩

example : (∃ x, p x ∧ r) ↔ (∃ x, p x) ∧ r := Iff.intro
  (fun ⟨w, hpw, hr⟩ => ⟨⟨w, hpw⟩, hr⟩)
  (fun ⟨⟨w, hw⟩, hr⟩ => ⟨w, hw, hr⟩ )

example : (∃ x, p x ∨ q x) ↔ (∃ x, p x) ∨ (∃ x, q x) := Iff.intro
  (fun ⟨w, hpq⟩ => hpq.elim (λ hp => Or.inl ⟨w, hp⟩)
                            (λ hq => Or.inr ⟨w, hq⟩))
  (fun hpq => hpq.elim (λ ⟨w, hp⟩ => ⟨w, Or.inl hp⟩)
                       (λ ⟨w, hq⟩ => ⟨w, Or.inr hq⟩))

example : (∀ x, p x) ↔ ¬ (∃ x, ¬ p x) := Iff.intro
  (fun hp => (λ ⟨w, hnp⟩ => absurd (hp w) hnp))
  (fun hnp => λ w =>
      byContradiction λ nhp => hnp ⟨w, nhp⟩)

example : (∃ x, p x) ↔ ¬ (∀ x, ¬ p x) := Iff.intro
  (fun ⟨w, hpw⟩ => (λ hpx => absurd hpw (hpx w)))
  (fun hnp =>
    byContradiction λ nepx =>
    have hp : ∀ x, ¬ p x := λ w =>
      byContradiction λ nnpw =>
      nepx ⟨w, not_not.mp nnpw⟩
    hnp hp
  )

example : (¬ ∃ x, p x) ↔ (∀ x, ¬ p x) := Iff.intro
  (fun hnep => (λ w => λ pw => hnep ⟨w, pw⟩ ))
  (fun hnpx => λ ⟨w, hpw⟩ => hnpx w hpw)

example : (¬ ∀ x, p x) ↔ (∃ x, ¬ p x) := Iff.intro
  (fun hnapx =>
    byContradiction λ (hnexnpx : ¬∃ x, ¬p x) =>
    have hapx : ∀ x, p x := λ w =>
    byContradiction λ npw => hnexnpx ⟨w, npw⟩
    hnapx hapx
  )
  (fun ⟨w, npw⟩ => λ px => absurd (px w) npw)

example : (∀ x, p x → r) ↔ (∃ x, p x) → r := Iff.intro
  (fun h => λ ⟨w, pw⟩ => h w pw)
  (fun h => λ w => λ pw => h ⟨w, pw⟩)

example (a : α) : (∃ x, p x → r) ↔ (∀ x, p x) → r := Iff.intro
  (fun ⟨w, pwr⟩ => λ haxpx => pwr (haxpx w))
  (fun hapr =>
    show ∃ x, p x → r from
    byCases
      (fun hap : ∀ x, p x =>
        ⟨a, λ _h' => hapr hap⟩)
      (fun hnap : ¬ ∀ x, p x =>
      byContradiction (fun hnex : ¬ ∃ x, p x → r =>
        have hap : ∀ x, p x := λ x => byContradiction
          (fun hnp : ¬ p x =>
            have hex : ∃ x, p x -> r := ⟨x, λ hpx => absurd hpx hnp⟩
            show False from hnex hex
          )
        show False from hnap hap
      )))

example (a : α) : (∃ x, r → p x) ↔ (r → ∃ x, p x) := Iff.intro
  (fun ⟨w, hrpw⟩ => λ hr => ⟨w, hrpw hr⟩)
  (fun hrepx =>
    show ∃ x, r → p x from
    byCases
      (fun hr : r => let ⟨w, pw⟩ := hrepx hr
      ⟨w, λ _hr' => pw⟩)
      (fun hnr : ¬r => ⟨a, λ hr => absurd hr hnr⟩)
    )


example : (∀ x, p x ∧ q x) ↔ (∀ x, p x) ∧ (∀ x, q x) := Iff.intro
  (fun h => ⟨λ w => (h w).left, λ w => (h w).right⟩)
  (fun ⟨hpx, hqx⟩ => λ w => ⟨hpx w, hqx w⟩)

example : (∀ x, p x → q x) → (∀ x, p x) → (∀ x, q x) :=
  fun hapqx hapx => λ w => (hapqx w) (hapx w)

example : (∀ x, p x) ∨ (∀ x, q x) → ∀ x, p x ∨ q x :=
  fun hpoq => hpoq.elim (λ hp => λ w => Or.inl (hp w))
                        (λ hq => λ w => Or.inr (hq w))

example : α → ((∀ _x : α, r) ↔ r) := fun a => Iff.intro
  (fun h => h a)
  (fun hr => λ _x => hr)

example : (∀ x, p x ∨ r) ↔ (∀ x, p x) ∨ r := byCases
  (fun hr : r => Iff.intro (fun _h => Or.inr hr) (fun _h _x => Or.inr hr))
  (fun hnr : ¬r => Iff.intro
    (fun h => Or.inl (λ w =>
      have hpor : p w ∨ r := h w
      hpor.elim id (λ hr => absurd hr hnr)))
    (fun h => λ w => h.elim
          (λ hapx => Or.inl (hapx w))
          (λ hr => absurd hr hnr)))

example : (∀ x, r → p x) ↔ (r → ∀ x, p x) := Iff.intro
  (fun harpx hhr x => harpx x hhr)
  (fun hraxpx x hr => hraxpx hr x)

-- Consider the “barber paradox,” that is, the claim that in a certain town
-- there is a (male) barber that shaves all and only the men who do not shave
-- themselves. Prove that this is a contradiction:
variable (men : Type) (barber : men)
variable (shaves : men → men → Prop)

example (h : ∀ x : men, shaves barber x ↔ ¬ shaves x x) : False :=
  (h barber).elim (fun forward backward => byCases
    (fun h : shaves barber barber => absurd h (forward h))
    (fun h : ¬shaves barber barber => absurd (backward h) h))

def even (n : Nat) : Prop := ∃ k, n = 2 * k

def prime (n : Nat) : Prop := ¬ ∃ k, 1 < k → k∣n

def infinitely_many_primes : Prop := ∀ n, prime n → ∃ m, m > n → prime m

def Fermat_prime (n : Nat) : Prop := sorry

def infinitely_many_Fermat_primes : Prop := sorry

def goldbach_conjecture : Prop := sorry

def Goldbach's_weak_conjecture : Prop := sorry

def Fermat's_last_theorem : Prop := sorry

example (p q r : Prop) (hp : p)
        : (p ∨ q ∨ r) ∧ (q ∨ p ∨ r) ∧ (q ∨ r ∨ p) := by
  simp [hp]
