// Created by Ayush Biswas at 2026/01/25 00:20
// https://atcoder.jp/contests/abc044/tasks/abc044_b
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
use std::collections::HashMap;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        s: String
    ) -> Bool {
        let counter : HashMap<char, usize> =
            s.chars()
            .sorted()
            .group_by(|&x| x)
            .map(|g| (g[0], g.len()))
            .collect();
        counter.iter().all(|(_k, v)| *v%2 == 0).into()
    }
}

// @code end
