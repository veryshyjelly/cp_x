// Created by Ayush Biswas at 2026/07/08 10:36
// https://atcoder.jp/contests/adt_medium_20250909_3/tasks/abc413_b
use cp_lib::*;

// @code begin
use cpio::*;
use std::collections::HashSet;

sol! {
    fn solution(
        n: usize,
        strs: [String]; n
    ) -> usize {
        let mut h: HashSet<String> = HashSet::new();
        for i in 0..n {
            for j in 0..n {
                if  i == j {
                    continue;
                }
                h.insert(format!("{}{}", strs[i], strs[j]));
            }
        }
        h.len()
    }
}
// @code end
