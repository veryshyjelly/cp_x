// Created by Ayush Biswas at 2026/01/20 14:08
// https://atcoder.jp/contests/abc042/tasks/abc042_a
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        abc : [usize; 3]
    ) -> BOOL {
        (abc.into_iter().sorted().collect_vec() == vec![5, 5, 7]).into()
    }
}
// @code end
