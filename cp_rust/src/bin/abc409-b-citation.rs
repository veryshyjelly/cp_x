// Created by Ayush Biswas at 2026/07/08 13:45
// https://atcoder.jp/contests/adt_medium_20250723_3/tasks/abc409_b
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        n: usize,
        (mut a): [usize]
    ) -> usize {
        a.sort();
        let mut res = 0;
        for (i, ai) in a.into_iter().enumerate() {
            res = res.max(ai.min(n - i));
        }
        res
    }
}
// @code end
