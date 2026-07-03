-- Created by Ayush Biswas at 2026/03/02 18:36
-- https://atcoder.jp/contests/abc046/tasks/abc046_b
-- @code begin

getInts :: IO [Int]
getInts = map read . words <$> getLine

main :: IO ()
main = do
  [n, k] <- getInts
  let res = k * (k - 1) ^ (n - 1)
  print res

-- @code end