#pragma once

/// @head begin
#include <numeric>
#include <vector>
/// @head end

/// @code begin
inline std::vector<int> range(const int n) {
    std::vector<int> v(n);
    std::iota(v.begin(), v.end(), 0);
    return v;
}
/// @code end
