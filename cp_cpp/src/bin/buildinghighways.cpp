// Created by Ayush Biswas at 2026/05/05 20:32
// https://open.kattis.com/problems/buildinghighways
/// @head begin
#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
/// @head end

/// @code begin
using namespace std;

void solve() {
    int n; cin >> n;
    vector<long long> v(n);
    for (int i = 0; i < n; i++) cin >> v[i];
    const auto m = *ranges::min_element(v);
    const auto s = accumulate(v.begin(), v.end(), 0LL);
    cout << m * (n - 2) + s;
}

int main() {
    cin.tie(nullptr);

    solve();
}
/// @code end
