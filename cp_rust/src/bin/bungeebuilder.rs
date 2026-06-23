// Created by Ayush Biswas at 2026/05/11 14:51
// https://open.kattis.com/problems/bungeebuilder
use cp_lib::*;

// @code begin
use cpio::*;

sol! {
    fn solution(
        n: usize,
        a: [usize]
    ) -> usize {
       let mut rmin = a[0];
       let mut rmax = a[0];
       let mut res = 0;
       for i in 0..n {
            rmin = rmin.min(a[i]);
            res = res.max(rmax.min(a[i]) - rmin);
            if a[i] > rmax {
                rmax = a[i];
                rmin = a[i];
            }
       }
       res
    }
}
// @code end
