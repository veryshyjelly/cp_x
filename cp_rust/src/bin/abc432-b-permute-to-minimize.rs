// Created by Ayush Biswas at 2026/07/08 10:00
// https://atcoder.jp/contests/adt_easy_20251224_1/tasks/abc432_b
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        n: [char]
    ) -> String {
        let mut g = n.into_iter().sorted().group_by(|&x| x).collect_vec();
        let f = if g[0][0] == '0' {
            g[1].pop().unwrap()
        } else {
            g[0].pop().unwrap()
        };
        let rest: String = g.iter().flatten().collect();
        format!("{f}{rest}")
    }
}
// @code end
