// Created by Ayush Biswas at 2026/01/24 22:14
// https://atcoder.jp/contests/abc043/tasks/arc059_b
use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        s : [char]
    ) -> Words<isize> {
        if let Some(p) = s.windows(2).position(|xy| xy[0] == xy[1]) {
            vec![p as isize + 1, p as isize + 2].into()
        } else if let Some(p) = s.windows(3).position(|xy| xy[0] == xy[2]) {
            vec![p as isize + 1, p as isize + 3].into()
        } else {
            vec![-1, -1].into()
        }
    }
}

// @code end
