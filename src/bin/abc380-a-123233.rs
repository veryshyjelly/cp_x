// Created by Ayush Biswas at 2026/07/08 22:14
// https://atcoder.jp/contests/adt_easy_20241226_2/tasks/abc380_a
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        n: [char]
    ) -> Bool {
        if !('1'..='3').all(|i| n.contains(&i)) {
            return false.into()
        }
        n
            .into_iter()
            .sorted()
            .group_by(|&x| x)
            .map(|g| g.len())
            .zip(1..=3)
            .all(|(i, j)| i == j)
            .into()
    }
}
// @code end
