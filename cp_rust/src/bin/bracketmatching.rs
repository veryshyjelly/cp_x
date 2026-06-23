// Created by Ayush Biswas at 2026/05/06 15:56
// https://open.kattis.com/problems/bracketmatching
use cp_lib::*;

// @code begin
use cpio::*;
use std::collections::HashMap;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        n: usize,
        s: String
    ) -> String {
        let mut stack: Vec<char> = Vec::with_capacity(n + 1);
        let opening: HashMap<char, char> = HashMap::from([
            (')', '('),
            (']', '['),
            ('}', '{')
        ]);
        for c in s.chars() {
            if opening.contains_key(&c) {
                if let Some(c_nemesis) = stack.pop() {
                   if c_nemesis != opening[&c] {
                        return "Invalid".into()
                   }
                } else {
                    return "Invalid".into()
                }
            } else {
                stack.push(c);
            }
        }
        if stack.is_empty() {
            "Valid".into()
        } else {
            "Invalid".into()
        }
    }
}

// @code end
