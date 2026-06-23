// Created by Ayush Biswas at 2026/05/06 20:41
// https://open.kattis.com/problems/fendofftitan
use cp_lib::*;

// @code begin
use cpio::*;
use std::cmp::Reverse;
use std::collections::BinaryHeap;
// const INF: u32 = 10u32.pow(9);
const INF: usize = 4 * 10usize.pow(18);

#[derive(Clone)]
struct Road {
    dest: usize,
    length: usize,
    enemy: Enemy,
}

#[derive(Copy, Clone)]
enum Enemy {
    None,
    Shaman,
    Titan,
}

impl From<usize> for Enemy {
    fn from(value: usize) -> Self {
        if value == 1 {
            Enemy::Shaman
        } else if value == 2 {
            Enemy::Titan
        } else {
            Enemy::None
        }
    }
}


#[derive(Ord, PartialOrd, Eq, PartialEq, Default, Clone)]
struct Cost {
    titans: usize,
    shamans: usize,
    distance: usize,
}

sol! {
    fn solution(
        [n, m, x, y]: [usize; 4],
        roads: [[usize; 4]; m]
    ) -> CPResult<Words<usize>, String> {
        let mut graph: Vec<Vec<Road>> = vec![vec![]; n + 1];
        for [a, b, length, c] in roads {
            let enemy = Enemy::from(c);
            graph[a].push(Road {dest : b, length, enemy});
            graph[b].push(Road {dest: a, length, enemy});
        }

        let mut dist: Vec<Cost> = vec![Cost{titans: INF, shamans: INF, distance: INF}; n + 1];
        dist[x] = Cost::default();

        let mut pq: BinaryHeap<Reverse<(Cost, usize)>> = BinaryHeap::new();
        pq.push(Reverse((Cost::default(), x)));

        while let Some(Reverse((cost, node))) = pq.pop() {
            if dist[node] != cost {
                continue; // stale
            }

            for neigh in &graph[node] {
                let mut new_cost = cost.clone();
                new_cost.distance += neigh.length;
                match neigh.enemy {
                    Enemy::Titan => new_cost.titans += 1,
                    Enemy::Shaman => new_cost.shamans += 1,
                    Enemy::None => {}
                }
                if new_cost < dist[neigh.dest] {
                    dist[neigh.dest] = new_cost.clone();
                    pq.push(Reverse((new_cost, neigh.dest)));
                }
            }
        }

        if dist[y].distance >= INF {
            Failure("IMPOSSIBLE".into())
        } else {
            let Cost {titans, shamans, distance} = dist[y];
            Success(vec![distance, shamans, titans].into())
        }

    }
}

// @code end
