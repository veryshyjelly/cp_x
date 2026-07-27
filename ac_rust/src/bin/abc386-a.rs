// Created by Ayush Biswas at 2026/07/26 20:07
// https://atcoder.jp/contests/adt_easy_20260626_1/tasks/abc386_a
// A - Full House 2

use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        cards: [usize; 4]
    ) -> Bool {
        (cards.into_iter().unique().count() == 2).into()
    }
}
