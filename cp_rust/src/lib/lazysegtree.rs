use super::internal_type_traits::Zero;
use super::monoid::Monoid;
use std::convert::Infallible;
use std::iter::FromIterator;
use std::marker::PhantomData;
use std::ops::{Add, Bound, Mul, RangeBounds};
// ---------------------------------------------------------------------------
// MapMonoid — extends a Monoid with a lazy "map" type F
// ---------------------------------------------------------------------------

/// A monoid equipped with a lazy action.
///
/// * `M`  — the underlying data monoid (e.g. sum, max, …)
/// * `F`  — the set of lazy "maps" (updates); must itself form a monoid
///          (identity + composition).
///
/// The three things you must provide:
/// 1. `identity_map`  — the map that leaves every element unchanged.
/// 2. `mapping`       — how one map transforms a single monoid element.
/// 3. `composition`   — how to compose two maps (f applied *after* g).
pub trait MapMonoid {
    type M: Monoid;
    type F: Clone + PartialEq;

    fn identity_map() -> Self::F;
    fn mapping(f: &Self::F, x: &<Self::M as Monoid>::S) -> <Self::M as Monoid>::S;
    fn composition(f: &Self::F, g: &Self::F) -> Self::F;
}

// ---------------------------------------------------------------------------
// LazySegTree
// ---------------------------------------------------------------------------

/// Segment tree with lazy propagation.
///
/// Supports:
/// - **Point / range set/update** — `apply`, `apply_range`
/// - **Range query**              — `prod`, `all_prod`
/// - **Binary search**            — `max_right`, `min_left`
///
/// All operations are *O(log n)*.
pub struct LazySegTree<F: MapMonoid> {
    n: usize,
    size: usize,
    log: usize,
    d: Vec<<F::M as Monoid>::S>,
    lz: Vec<F::F>,
}

// ----- construction --------------------------------------------------------

impl<F: MapMonoid> Default for LazySegTree<F> {
    fn default() -> Self {
        LazySegTree::new(0)
    }
}

impl<F: MapMonoid> LazySegTree<F> {
    /// Build a tree of `n` identity elements.
    pub fn new(n: usize) -> Self {
        vec![<F::M as Monoid>::identity(); n].into()
    }
}

impl<F: MapMonoid> From<Vec<<F::M as Monoid>::S>> for LazySegTree<F> {
    fn from(v: Vec<<F::M as Monoid>::S>) -> Self {
        let n = v.len();
        let log = {
            // smallest k such that 2^k >= n
            let mut k = 0usize;
            while (1 << k) < n {
                k += 1;
            }
            k
        };
        let size = 1 << log;
        let mut d = vec![<F::M as Monoid>::identity(); 2 * size];
        d[size..][..n].clone_from_slice(&v);
        let lz = vec![F::identity_map(); size];
        let mut tree = LazySegTree { n, size, log, d, lz };
        for i in (1..size).rev() {
            tree.pull_up(i);
        }
        tree
    }
}

impl<F: MapMonoid> FromIterator<<F::M as Monoid>::S> for LazySegTree<F> {
    fn from_iter<T: IntoIterator<Item=<F::M as Monoid>::S>>(iter: T) -> Self {
        iter.into_iter().collect::<Vec<_>>().into()
    }
}

// ----- core helpers --------------------------------------------------------

impl<F: MapMonoid> LazySegTree<F> {
    /// Recompute internal node `k` from its two children.
    fn pull_up(&mut self, k: usize) {
        self.d[k] = <F::M as Monoid>::binary_operation(&self.d[2 * k], &self.d[2 * k + 1]);
    }

    /// Apply map `f` to node `k`, updating both the stored value and the lazy tag.
    fn all_apply(&mut self, k: usize, f: &F::F) {
        self.d[k] = F::mapping(f, &self.d[k]);
        if k < self.size {
            self.lz[k] = F::composition(f, &self.lz[k]);
        }
    }

    /// Push the lazy tag of node `k` down to its two children.
    fn push_down(&mut self, k: usize) {
        if self.lz[k] != F::identity_map() {
            let f = self.lz[k].clone();
            self.all_apply(2 * k, &f);
            self.all_apply(2 * k + 1, &f);
            self.lz[k] = F::identity_map();
        }
    }

    /// Push all ancestors of leaf `p` (in the array sense) top-down.
    fn push_all_above(&mut self, p: usize) {
        for i in (1..=self.log).rev() {
            self.push_down(p >> i);
        }
    }

    /// Re-pull all ancestors of leaf `p` bottom-up.
    fn pull_all_above(&mut self, p: usize) {
        for i in 1..=self.log {
            let k = p >> i;
            if self.lz[k] == F::identity_map() {
                self.pull_up(k);
            }
        }
    }
}

// ----- public API ----------------------------------------------------------

impl<F: MapMonoid> LazySegTree<F> {
    /// Overwrite position `p` with `x`.
    pub fn set(&mut self, mut p: usize, x: <F::M as Monoid>::S) {
        assert!(p < self.n);
        p += self.size;
        self.push_all_above(p);
        self.d[p] = x;
        self.pull_all_above(p);
    }

    /// Return a clone of the value at position `p`.
    pub fn get(&mut self, mut p: usize) -> <F::M as Monoid>::S {
        assert!(p < self.n);
        p += self.size;
        self.push_all_above(p);
        self.d[p].clone()
    }

    /// Query the monoid product over `range`.
    pub fn prod<R: RangeBounds<usize>>(&mut self, range: R) -> <F::M as Monoid>::S {
        if range.start_bound() == Bound::Unbounded && range.end_bound() == Bound::Unbounded {
            return self.all_prod();
        }

        let mut l = match range.start_bound() {
            Bound::Included(&l) => l,
            Bound::Excluded(&l) => l + 1,
            Bound::Unbounded => 0,
        };
        let mut r = match range.end_bound() {
            Bound::Included(&r) => r + 1,
            Bound::Excluded(&r) => r,
            Bound::Unbounded => self.n,
        };
        assert!(l <= r && r <= self.n);

        if l == r {
            return <F::M as Monoid>::identity();
        }

        l += self.size;
        r += self.size;

        // Push lazy tags on the path to both endpoints.
        for i in (1..=self.log).rev() {
            if ((l >> i) << i) != l {
                self.push_down(l >> i);
            }
            if ((r >> i) << i) != r {
                self.push_down((r - 1) >> i);
            }
        }

        let mut sml = <F::M as Monoid>::identity();
        let mut smr = <F::M as Monoid>::identity();
        let (mut l2, mut r2) = (l, r);
        while l2 < r2 {
            if l2 & 1 != 0 {
                sml = <F::M as Monoid>::binary_operation(&sml, &self.d[l2]);
                l2 += 1;
            }
            if r2 & 1 != 0 {
                r2 -= 1;
                smr = <F::M as Monoid>::binary_operation(&self.d[r2], &smr);
            }
            l2 >>= 1;
            r2 >>= 1;
        }

        <F::M as Monoid>::binary_operation(&sml, &smr)
    }

    /// Return the product over the entire array.
    pub fn all_prod(&self) -> <F::M as Monoid>::S {
        self.d[1].clone()
    }

    /// Apply map `f` to position `p`.
    pub fn apply(&mut self, mut p: usize, f: &F::F) {
        assert!(p < self.n);
        p += self.size;
        self.push_all_above(p);
        self.d[p] = F::mapping(f, &self.d[p]);
        self.pull_all_above(p);
    }

    /// Apply map `f` to every element in `range`.
    pub fn apply_range<R: RangeBounds<usize>>(&mut self, range: R, f: &F::F) {
        let mut l = match range.start_bound() {
            Bound::Included(&l) => l,
            Bound::Excluded(&l) => l + 1,
            Bound::Unbounded => 0,
        };
        let mut r = match range.end_bound() {
            Bound::Included(&r) => r + 1,
            Bound::Excluded(&r) => r,
            Bound::Unbounded => self.n,
        };
        assert!(l <= r && r <= self.n);

        if l == r {
            return;
        }

        l += self.size;
        r += self.size;

        // Push lazy tags on the path to both endpoints.
        for i in (1..=self.log).rev() {
            if ((l >> i) << i) != l {
                self.push_down(l >> i);
            }
            if ((r >> i) << i) != r {
                self.push_down((r - 1) >> i);
            }
        }

        let (l0, r0) = (l, r);
        while l < r {
            if l & 1 != 0 {
                self.all_apply(l, f);
                l += 1;
            }
            if r & 1 != 0 {
                r -= 1;
                self.all_apply(r, f);
            }
            l >>= 1;
            r >>= 1;
        }

        // Re-pull all touched internal nodes.
        for i in 1..=self.log {
            if ((l0 >> i) << i) != l0 {
                let k = l0 >> i;
                if self.lz[k] == F::identity_map() {
                    self.pull_up(k);
                }
            }
            if ((r0 >> i) << i) != r0 {
                let k = (r0 - 1) >> i;
                if self.lz[k] == F::identity_map() {
                    self.pull_up(k);
                }
            }
        }
    }

    /// Find the furthest right index such that `f` holds for `prod(l..index)`.
    ///
    /// Requires `f(identity) == true`.  Returns `n` if `f` holds everywhere.
    pub fn max_right<G>(&mut self, mut l: usize, g: G) -> usize
    where
        G: Fn(&<F::M as Monoid>::S) -> bool,
    {
        assert!(l <= self.n);
        assert!(g(&<F::M as Monoid>::identity()));
        if l == self.n {
            return self.n;
        }
        l += self.size;
        self.push_all_above(l);

        let mut sm = <F::M as Monoid>::identity();
        loop {
            while l % 2 == 0 {
                l >>= 1;
            }
            if !g(&<F::M as Monoid>::binary_operation(&sm, &self.d[l])) {
                while l < self.size {
                    self.push_down(l);
                    l *= 2;
                    let res = <F::M as Monoid>::binary_operation(&sm, &self.d[l]);
                    if g(&res) {
                        sm = res;
                        l += 1;
                    }
                }
                return l - self.size;
            }
            sm = <F::M as Monoid>::binary_operation(&sm, &self.d[l]);
            l += 1;
            let l_isize = l as isize;
            if (l_isize & -l_isize) == l_isize {
                break;
            }
        }
        self.n
    }

    /// Find the furthest left index such that `f` holds for `prod(index..r)`.
    ///
    /// Requires `f(identity) == true`.  Returns `0` if `f` holds everywhere.
    pub fn min_left<G>(&mut self, mut r: usize, g: G) -> usize
    where
        G: Fn(&<F::M as Monoid>::S) -> bool,
    {
        assert!(r <= self.n);
        assert!(g(&<F::M as Monoid>::identity()));
        if r == 0 {
            return 0;
        }
        r += self.size;
        self.push_all_above(r - 1);

        let mut sm = <F::M as Monoid>::identity();
        loop {
            r -= 1;
            while r > 1 && r % 2 == 1 {
                r >>= 1;
            }
            if !g(&<F::M as Monoid>::binary_operation(&self.d[r], &sm)) {
                while r < self.size {
                    self.push_down(r);
                    r = 2 * r + 1;
                    let res = <F::M as Monoid>::binary_operation(&self.d[r], &sm);
                    if g(&res) {
                        sm = res;
                        r -= 1;
                    }
                }
                return r + 1 - self.size;
            }
            sm = <F::M as Monoid>::binary_operation(&self.d[r], &sm);
            let r_isize = r as isize;
            if (r_isize & -r_isize) == r_isize {
                break;
            }
        }
        0
    }
}

// ---------------------------------------------------------------------------
// Built-in MapMonoid: RangeAddRangeSum
// ---------------------------------------------------------------------------
//
// Monoid element  S = (sum: i64, size: usize)
//   • identity            : (0, 0)   — a zero-length segment
//   • binary_operation    : add sums, add sizes
//
// Lazy map        F = i64  (the addend)
//   • identity_map        : 0
//   • mapping(f, (s, n))  : (s + f * n as i64, n)
//   • composition(f, g)   : f + g
//
// Usage:
//   let mut tree: LazySegTree<RangeAddRangeSum<i64>> =
//       vec![(0, 1); n].into();  // or use LazySegTree::new(n)
//
// For convenience, `RangeAddSumTree` is a ready-made type alias + factory.

/// Marker struct for the range-add / range-sum map monoid over `i64`.
pub struct RangeAddRangeSum<S>(Infallible, PhantomData<fn() -> S>);

/// A monoid whose element is `(sum, segment_length)`.
pub struct SumWithSize<S>(Infallible, PhantomData<fn() -> S>);

impl<S> Monoid for SumWithSize<S>
where
    S: Copy + Add<Output=S> + Zero,
{
    type S = (S, usize); // (sum, length)

    fn identity() -> Self::S {
        (S::zero(), 0)
    }

    fn binary_operation(a: &Self::S, b: &Self::S) -> Self::S {
        (a.0 + b.0, a.1 + b.1)
    }
}

impl MapMonoid for RangeAddRangeSum<isize> {
    type M = SumWithSize<isize>;
    type F = isize; // addend

    fn identity_map() -> Self::F {
        0
    }

    fn mapping(f: &Self::F, x: &(isize, usize)) -> (isize, usize) {
        (x.0 + f * x.1 as isize, x.1)
    }

    fn composition(f: &Self::F, g: &Self::F) -> Self::F {
        f + g
    }
}

/// Convenience alias: a lazy segment tree supporting
/// - `apply_range(l..r, delta)` — add `delta` to every element in `[l, r)`
/// - `prod(l..r)` — returns `(sum, length)`; use `.0` for the sum
pub type RangeAddSumTree = LazySegTree<RangeAddRangeSum<isize>>;

impl RangeAddSumTree {
    /// Build from a plain `Vec<i64>` (each element has implicit length 1).
    pub fn from_values(v: Vec<isize>) -> Self {
        v.into_iter().map(|x| (x, 1usize)).collect()
    }

    /// Build `n` zeros.
    pub fn zeros(n: usize) -> Self {
        Self::from_values(vec![0; n])
    }

    /// Add `delta` to every position in `range`.
    pub fn range_add<R: RangeBounds<usize>>(&mut self, range: R, delta: isize) {
        self.apply_range(range, &delta);
    }

    /// Sum of elements in `range`.
    pub fn range_sum<R: RangeBounds<usize>>(&mut self, range: R) -> isize {
        self.prod(range).0
    }

    /// Collect the final element values into a `Vec<i64>` after all updates.
    pub fn get_vec(&mut self) -> Vec<isize> {
        (0..self.n).map(|i| self.get(i).0).collect()
    }
}

pub struct RangeSetAddRangeSum<S>(Infallible, PhantomData<fn() -> S>);

impl<S> MapMonoid for RangeSetAddRangeSum<S>
where
    S: Copy + Add<Output=S> + Mul<Output=S> + Zero + PartialEq + TryFrom<usize>,
{
    type M = SumWithSize<S>;
    type F = (Option<S>, S); // (set, add)

    fn identity_map() -> Self::F {
        (None, S::zero())
    }

    fn mapping(f: &Self::F, x: &(S, usize)) -> (S, usize) {
        let len = S::try_from(x.1).unwrap_or(S::zero());
        let base = match f.0 {
            Some(v) => v * len,
            None => x.0,
        };
        (base + f.1 * len, x.1)
    }

    fn composition(f: &Self::F, g: &Self::F) -> Self::F {
        match f.0 {
            Some(_) => *f,
            None => (g.0, g.1 + f.1),
        }
    }
}


// Type alias is generic too now
pub type RangeSetAddSumTree<S> = LazySegTree<RangeSetAddRangeSum<S>>;

impl<S> RangeSetAddSumTree<S>
where
    S: Copy + Add<Output=S> + Mul<Output=S> + Zero + PartialEq + TryFrom<usize>,
{
    pub fn from_values(v: Vec<S>) -> Self {
        v.into_iter().map(|x| (x, 1usize)).collect()
    }

    pub fn zeros(n: usize) -> Self {
        Self::from_values(vec![S::zero(); n])
    }

    pub fn range_set<R: RangeBounds<usize>>(&mut self, range: R, val: S) {
        self.apply_range(range, &(Some(val), S::zero()));
    }

    pub fn range_add<R: RangeBounds<usize>>(&mut self, range: R, delta: S) {
        self.apply_range(range, &(None, delta));
    }

    pub fn range_sum<R: RangeBounds<usize>>(&mut self, range: R) -> S {
        self.prod(range).0
    }

    pub fn get_vec(&mut self) -> Vec<S> {
        (0..self.n).map(|i| self.get(i).0).collect()
    }
}
