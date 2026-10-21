// Created by Ayush Biswas at 2026/07/07 21:35
// https://atcoder.jp/contests/adt_easy_20260407_2/tasks/abc448_b
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        [n, m]: [usize; 2],
        (mut peppers): [usize],
        abs: [[usize; 2]; n]
    ) -> usize {
        let mut res = 0;
        for [a, b] in abs {
            let sprinkl = peppers[a - 1].min(b);
            res += sprinkl;
            peppers[a - 1] -= sprinkl;
        }
        res
    }
}
// @code end
