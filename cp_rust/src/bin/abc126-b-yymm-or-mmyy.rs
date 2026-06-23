// Created by Ayush Biswas at 2026/06/09 19:41
// https://atcoder.jp/contests/abc126/tasks/abc126_b
use cp_lib::*;

// @code begin
use cpio::*;

fn is_month(part: &str) -> bool {
    let code: usize = part.parse().unwrap();
    code > 0 && code <= 12
}

sol! {
    fn solution(
        s: String
    ) -> String {
        let front_month = is_month(&s[0..=1]);
        let back_month = is_month(&s[2..=3]);
        if front_month && back_month {
            "AMBIGUOUS"
        } else if front_month {
            "MMYY"
        } else if back_month {
            "YYMM"
        } else {
            "NA"
        }.into()
    }
}

// @code end
