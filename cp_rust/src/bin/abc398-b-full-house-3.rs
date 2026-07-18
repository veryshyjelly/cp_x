// Created by Ayush Biswas at 2026/07/08 16:06
// https://atcoder.jp/contests/adt_medium_20250605_3/tasks/abc398_b
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;

sol! {
    fn solution(
        cards: [usize]
    ) -> Bool {
        let groups = cards.into_iter().sorted().group_by(|&x| x).map(|g| g.len()).collect_vec();
        let twos = groups.iter().count_where(|&&x| x >= 2);
        let threes = groups.iter().count_where(|&&x| x >= 3);
        (twos >= 2 && threes > 0).into()
    }
}
// @code end
