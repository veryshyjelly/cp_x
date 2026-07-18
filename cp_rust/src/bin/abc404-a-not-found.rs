// Created by Ayush Biswas at 2026/07/06 22:54
// https://atcoder.jp/contests/adt_easy_20260625_1/tasks/abc404_a
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        s: [char]
    ) -> char {
        let mut z = s.into_iter().sorted().group_by(|&x| x).map(|g| g[0]);
        for a in 'a'..='z' {
            if let Some(b) = z.next() {
                if a != b {
                    return a;
                }
            } else {
                return a;
            }
        }
        'z'
    }
}
// @code end
