// Created by Ayush Biswas at 2026/07/06 17:41
// https://atcoder.jp/contests/adt_easy_20260626_1/tasks/abc386_a
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        (mut cards): [usize],
    ) -> Bool {
        cards.sort();
        (cards.iter().group_by(|&x| x).count() == 2).into()
    }
}
// @code end
