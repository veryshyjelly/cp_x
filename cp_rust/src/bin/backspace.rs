// Created by Ayush Biswas at 2026/05/10 16:59
// https://open.kattis.com/problems/backspace
use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

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
