// Created by Ayush Biswas at 2026/07/26 20:24
// https://atcoder.jp/contests/adt_easy_20260625_1/tasks/abc404_a
// B - Not Found

use cpio::*;
use std::collections::HashSet;

sol! {
    fn solution(
        s: Chars
    ) -> char {
        let t: HashSet<char> = s.into_iter().collect();
        ('a'..='z').find(|c| !t.contains(c)).unwrap()
    }
}
