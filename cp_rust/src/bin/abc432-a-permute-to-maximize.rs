// Created by Ayush Biswas at 2026/07/08 00:52
// https://atcoder.jp/contests/adt_easy_20260107_3/tasks/abc432_a
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        (mut digs): [String]
    ) -> String {
        digs.sort();
        digs.reverse();
        digs.join("")
    }
}
// @code end
