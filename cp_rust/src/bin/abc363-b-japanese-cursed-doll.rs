// Created by Ayush Biswas at 2026/07/10 22:38
// https://atcoder.jp/contests/adt_easy_20240903_1/tasks/abc363_b
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        [_n, t, p]: [usize; 3],
        a: [usize]
    ) -> usize {
        let grps = a
            .into_iter()
            .sorted()
            .group_by(|&x| x)
            .map(|g| (g.len(), g[0])).collect_vec();
        let mut taken = 0;
        for (count, length) in grps.into_iter().rev() {
            taken += count;
            if taken >= p {
                return t.saturating_sub(length);
            }
        }
        0
    }
}
// @code end
