// Created by Ayush Biswas at 2026/07/26 18:33
// https://atcoder.jp/contests/adt_all_20260629_2/tasks/abc242_b
// D - Minimize Ordering

use cpio::*;
use itertools::*;

sol! {
    fn solution(
        s: Chars
    ) -> String {
        s.iter().sorted().collect()
    }
}
