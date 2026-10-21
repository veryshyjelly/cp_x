// Created by Ayush Biswas at 2026/04/18 14:41
// https://open.kattis.com/problems/brillianceofwings

/// @head begin
#include <set>
#include <vector>
#include <ranges>
#include <iostream>
#include <algorithm>
/// @head end

/// @code begin
using namespace std;

void sol() {
    int n; cin >> n;
    vector<set<int>> graph1(n + 1);
    for (int i = 1; i < n; i++) {
        int x, y; cin >> x >> y;
        graph1[x].insert(y);
        graph1[y].insert(x);
    }
    vector<set<int>> graph2(n + 1);
    for (int i = 1; i < n; i++) {
        int x, y; cin >> x >> y;
        graph2[x].insert(y);
        graph2[y].insert(x);
    }

    set<int> r;
    int res = 2*(n - 1);
    for (auto [a, b] : views::zip(graph1, graph2)) {
        ranges::set_intersection(a, b, inserter(r, r.begin()));
        res -= (int) r.size();
    }

    cout << res / 2 << endl;
}

int main() {
    cin.tie(nullptr);

    sol();
    return 0;
}
/// @code end
