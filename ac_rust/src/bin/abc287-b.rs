// Created by Ayush Biswas at 2026/07/26 22:27
// https://atcoder.jp/contests/adt_easy_20260625_1/tasks/abc287_b
// C - Postal Card

use cpio::*;
use std::collections::HashSet;

sol! {
    fn solution(
        n: usize, m: usize,
        s: [String; n],
        t: [String; m]
    ) -> usize {
        let t: HashSet<String> = t.into_iter().collect();
        s.into_iter().filter(|si| t.contains(&si[3..6])).count()
    }
}
