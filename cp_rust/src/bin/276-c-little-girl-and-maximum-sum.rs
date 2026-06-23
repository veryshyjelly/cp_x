// Created by Ayush Biswas at 2026/05/18 18:09
// https://codeforces.com/problemset/problem/276/C
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
use lazysegtree::RangeSetAddSumTree;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        [n, q]: [usize; 2],
        a: [usize],
        queries: [[usize; 2]; q]
    ) -> usize {
        let mut seg: RangeSetAddSumTree<usize> = RangeSetAddSumTree::zeros(n);
        for [l, r] in queries {
            seg.range_add(l-1..=r-1, 1);
        }

        let mut values = seg.get_vec();

        values.sort();
        a
        .into_iter()
        .sorted()
        .zip(values)
        .map(|(ai, vi)| ai * vi)
        .sum::<usize>()
    }
}

// @code end
