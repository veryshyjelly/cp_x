// Created by Ayush Biswas at 2026/07/07 11:35
// https://atcoder.jp/contests/adt_easy_20260625_1/tasks/abc287_b
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
use std::collections::HashSet;

sol! {
    fn solution(
        [n, m]: [usize; 2],
        s: [usize]; n,
        t: [usize]; m,
    ) -> usize {
        let ts: HashSet<usize> = HashSet::from_iter(t.into_iter());
        s.into_iter().count_where(|si| {
            ts.contains(&(si % 1000))
        })
    }
}
// @code end
