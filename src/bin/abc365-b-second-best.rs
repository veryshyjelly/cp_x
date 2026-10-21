// Created by Ayush Biswas at 2026/07/08 21:58
// https://atcoder.jp/contests/adt_easy_20241231_1/tasks/abc365_b
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
use std::cmp::Reverse;

sol! {
    fn solution(
        _n: usize,
        a: [usize]
    ) -> usize {
        a.into_iter()
            .enumerate()
            .sorted_by_key(|(_, x)| Reverse(*x))
            .nth(1)
            .unwrap().0
        + 1
    }
}
// @code end
