// Created by Ayush Biswas at 2026/06/08 17:01
// https://atcoder.jp/contests/abc126/tasks/abc126_a
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        [n, k]: [usize; 2],
        (mut s): [char]
    ) -> String {
        s[k - 1] = s[k - 1].to_lowercase().to_string().chars().next().unwrap();
        s.into_iter().collect()
    }
}
// @code end
