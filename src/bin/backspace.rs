// Created by Ayush Biswas at 2026/05/10 16:59
// https://open.kattis.com/problems/backspace
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        s: [char]
    ) -> String {
        let mut res = vec![];
        for c in s {
            if c == '<' {
                res.pop();
            } else {
                res.push(c)
            }
        }
        res.into_iter().collect()
    }
}
// @code end
