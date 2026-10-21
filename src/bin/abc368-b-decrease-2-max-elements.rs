// Created by Ayush Biswas at 2026/07/10 22:17
// https://atcoder.jp/contests/adt_easy_20241001_2/tasks/abc368_b
use cp_lib::*;

// @code begin
use cpio::*;
use std::cmp::Reverse;

sol! {
    fn solution(
        _n: usize,
        (mut a): [usize]
    ) -> usize {
        let mut res = 0;
        loop {
            a.sort_by_key(|&x| Reverse(x));
            if a[1] == 0 {
                break;
            }
            a[0] -= 1;
            a[1] -= 1;
            res += 1;
        }
        res
    }
}
// @code end
