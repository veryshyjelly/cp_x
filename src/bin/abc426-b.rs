// Created by Ayush Biswas at 2026/07/27 16:59
// https://atcoder.jp/contests/adt_easy_20260618_1/tasks/abc426_b
// D - The Odd One Out

use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        s: Chars
    ) -> char {
        s.into_iter()
            .counts()
            .into_iter()
            .find_map(|(k, v)|
            if v == 1 {
                Some(k)
            } else {
                None
            }).unwrap()
    }
}
