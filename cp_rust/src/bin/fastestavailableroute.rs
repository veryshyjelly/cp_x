// Created by Ayush Biswas at 2026/05/07 08:19
// https://open.kattis.com/problems/fastestavailableroute
use cp_lib::*;

// @code begin
use cpio::*;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        [h, w, s]: [usize; 3],
        maze: [[char]; h]
    ) -> String {
    let mut path_cells: u128 = 0;
    for i in 0..h {
        for j in 0..w {
            if matches!(maze[i][j], '@' | '.' | '$') {
                path_cells += 1;
            }
        }
    }
    format!("Your destination will arrive in {} meters", (path_cells - 1) * (s as u128))
    }
}

// @code end
