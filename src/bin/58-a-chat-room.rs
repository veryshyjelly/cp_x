// Created by Ayush Biswas at 2025/08/24 10:47
// https://codeforces.com/problemset/problem/58/A
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        s: String
    ) -> BOOL {
        let mut it = s.chars();
        for c in "hello".chars() {
            let found = it.find(|&i| i == c).is_some();
            if !found {
                return false.into()
            }
        }
        true.into()
    }
}
// @code end
