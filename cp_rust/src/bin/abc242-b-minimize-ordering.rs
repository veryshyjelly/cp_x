// Created by Ayush Biswas at 2026/07/06 13:44
// https://atcoder.jp/contests/adt_all_20260629_2/tasks/abc242_b
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        (mut s): [char]
    ) -> String {
        s.sort();
        s.into_iter().collect()
    }
}
// @code end
