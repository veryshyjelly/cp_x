// Created by Ayush Biswas at 2026/05/06 19:39
// https://open.kattis.com/problems/knightjump
use cp_lib::*;

// @code begin
use cpio::*;
use std::collections::{HashSet, VecDeque};
// const INF: u32 = 10u32.pow(9);
const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        n: usize,
        grid: [[char]; n]
    ) -> CPResult<usize, isize> {
        let mut blocked = HashSet::new();

        let mut start = (0, 0);

        for i in 0..n {
            for j in 0..n {
                let c = grid[i][j];
                if c == '#' {
                    blocked.insert(i * n + j);
                } else if c == 'K' {
                    start = (i, j);
                }
            }
        }

        let moves = [
                (1isize, 2isize), (1, -2), (-1, 2), (-1, -2),
                (2, 1), (-2, 1), (2, -1), (-2, -1)
        ];

        let is_valid = |i: isize| i >= 0 && i < n as isize;

        let mut dist = vec![vec![INF; n]; n];
        dist[start.0][start.1] = 0;

        let mut queue = VecDeque::from([start]);
        while let Some((x, y)) = queue.pop_front() {
            let d = dist[x][y];
            for (dx, dy) in moves {
                let (x1, y1) = (x as isize + dx, y as isize + dy);
                if is_valid(x1) && is_valid(y1) {
                    let (x2, y2) = (x1 as usize, y1 as usize);
                    if blocked.contains(&(x2 * n + y2)) {
                        continue;
                    }
                    let dnxt = dist[x2][y2];
                    if dnxt > d + 1 {
                        dist[x2][y2] = d + 1;
                        queue.push_back((x2, y2));
                    }
                }
            }
        }

        if dist[0][0] != INF {
            Success(dist[0][0])
        } else {
            Failure(-1)
        }
    }
}

// @code end
