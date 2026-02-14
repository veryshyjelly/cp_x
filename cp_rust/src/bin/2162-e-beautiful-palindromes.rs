// Created by Ayush Biswas at 2025/11/17 21:27
// https://codeforces.com/problemset/problem/2162/E
use cp_lib::*;

use cpio::*;
// @code begin
// const INF: u32 = 10u32.pow(9);
// const INF: usize = 4 * 10usize.pow(18);

sol_n! {
    fn solution(
        [n, k]: [usize; 2],
        a: [usize]
    ) -> String {
        let mut out = String::new();
        let mut aai = vec![0; n + 1];
        for &ai in &a {
            aai[ai] += 1;
        }
        let z = a[n - 1];
        let res = if let Some(x) = (1..=n).find(|&x| aai[x] == 0) {
            let y = (1..=n).find(|&s| s != x && s != z).unwrap();
            [x, y, z].to_vec()
        } else {
            a.into_iter().take(3).collect()
        };

        for i in res.iter().cycle().take(k) {
            out.push_str(&format!("{i} "));
        }

        out
    }
}

// @code end
