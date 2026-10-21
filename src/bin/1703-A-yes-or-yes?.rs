// Created by Ayush Biswas at 2026/07/07 23:10
// https://codeforces.com/problemset/problem/1703/A
use cp_lib::*;

// @code begin
use cpio::*;

sol_n! {
    fn solution(
        s: String
    ) -> Bool {
        (s.to_uppercase() == "YES").into()
    }
}
// @code end
