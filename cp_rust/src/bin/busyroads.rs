// Created by Ayush Biswas at 2026/05/16 09:42
// https://open.kattis.com/problems/busyroads
use cp_lib::*;

// @code begin
use cpio::*;
use std::cmp::Reverse;
use std::collections::BinaryHeap;
const INF: usize = 4 * 10usize.pow(18);

#[derive(Clone)]
struct Road {
    to: usize,
    duration: usize,
    start: usize,
    end: usize,
}

sol! {
    fn solution(
        [n, m, c]: [usize; 3],
        roads: [[usize; 5]; m]
    ) -> usize {
        let mut graph = vec![vec![]; n + 1];
        for [a, b, t, l, r] in roads {
            graph[a].push(Road {
                to: b,
                duration: t,
                start: l,
                end: r
            });
            graph[b].push(Road {
                to: a,
                duration: t,
                start: l,
                end: r
            });
        }
        let mut distance = vec![INF; n + 1];
        distance[1] = 0;
        let mut pq = BinaryHeap::from([Reverse((0, 1))]);
        while let Some(Reverse((d, node))) = pq.pop() {
            if distance[node] != d {
                continue;
            }
            for road in &graph[node] {
                let d2 = if d%c > road.end {
                    (d/c + 1) * c + road.start + road.duration
                } else if d%c < road.start {
                    (d/c) * c + road.start + road.duration
                } else {
                    d + road.duration
                };
                if d2 < distance[road.to] {
                    distance[road.to] = d2;
                    pq.push(Reverse((d2, road.to)));
                }
            }
        }
        distance[n]
    }
}

// @code end
