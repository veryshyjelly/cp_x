// Created by Ayush Biswas at 2026/07/07 13:07
// https://atcoder.jp/contests/adt_easy_20260618_1/tasks/abc426_b
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        s: String
    ) -> char {
        let c = s
            .chars()
            .sorted()
            .group_by(|&x| x)
            .filter(|g| g.len() == 1)
            .next()
            .unwrap();
        c[0]
    }
}
// @code end
