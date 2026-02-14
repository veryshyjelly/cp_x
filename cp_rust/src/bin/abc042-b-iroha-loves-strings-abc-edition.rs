// Created by Ayush Biswas at 2026/01/20 14:13
// https://atcoder.jp/contests/abc042/tasks/abc042_b
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        [n, _l] : [usize; 2],
        strings : [String]; n
    ) -> String {
        strings.into_iter().sorted().collect_vec().join("")
    }
}

// @code end
