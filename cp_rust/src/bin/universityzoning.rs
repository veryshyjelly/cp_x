// Created by Ayush Biswas at 2026/05/08 22:01
// https://open.kattis.com/problems/universityzoning
use cp_lib::*;

// @code begin
use cpio::*;
use itertools::Itertools;
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol! {
    fn solution(
        [r, c, f, s, g]: [usize; 5],
        faculties: [[usize]; f],
        students: [[usize; 4]; s],
        targets: [usize]
    ) -> usize {
        let mut faculty_cells: Vec<Vec<(usize, usize)>> = vec![];
        for fac in faculties {
            let k = fac[0];
            let mut r = vec![];
            for i in 0..k {
                r.push((fac[2 * i + 1], fac[2 * i + 2]));
            }
            r.sort();
            r.reverse();
            faculty_cells.push(r);
        }

        let mut fac_times: Vec<Vec<usize>> = vec![vec![]; f];
        for [r, c, d, f] in students
            .into_iter()
            .sorted_by_key(|[_, _, d, _]| *d) {
            let (r1, c1) = faculty_cells[f-1].pop().unwrap();
            fac_times[f-1].push(r.abs_diff(r1) + c.abs_diff(c1));
        }

        fac_times
            .into_iter()
            .zip(targets)
            .map(|(f, target)|
                f.into_iter().sorted().take(target).sum::<usize>()
            )
            .sorted()
            .take(g)
            .sum()
    }
}

// @code end
