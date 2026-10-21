/// Binary search for the first index in [lo, hi)
/// such that `pred(mid) == true`.
pub fn search_right<F>(mut lo: usize, mut hi: usize, pred: F) -> usize
where
    F: Fn(usize) -> bool,
{
    while lo < hi {
        let mid = (lo + hi) / 2;
        if pred(mid) {
            hi = mid;
        } else {
            lo = mid + 1;
        }
    }
    lo
}

/// Binary search for the first index in [lo, hi)
/// such that `pred(mid) == false`, assuming
/// pred is true...true...true false...false.
pub fn search_left<F>(mut lo: usize, mut hi: usize, pred: F) -> usize
where
    F: Fn(usize) -> bool,
{
    while lo < hi {
        let mid = (lo + hi) / 2;
        if pred(mid) {
            lo = mid + 1;
        } else {
            hi = mid;
        }
    }
    lo
}
