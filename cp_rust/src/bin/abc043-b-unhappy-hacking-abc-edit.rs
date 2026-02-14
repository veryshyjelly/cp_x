// Created by Ayush Biswas at 2026/01/20 20:34
// https://atcoder.jp/contests/abc043/tasks/abc043_b
use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        s: String
    ) -> String {
        s.chars().fold(vec![], |mut acc, c| {
            if c == 'B' {
                acc.pop();
            } else {
                acc.push(c)
            }
            acc
        }).into_iter().collect()
    }
}

// @code end
