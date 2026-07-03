-- Created by Ayush Biswas at 2026/03/02 19:43
-- https://atcoder.jp/contests/abc047/tasks/abc047_a
-- @code begin

import Data.List

main :: IO ()
main = do
  [a, b, c] :: [Int] <- sort . map read . words <$> getLine
  let evenlyDivisible = a + b == c
  putStrLn $ if evenlyDivisible then "Yes" else "No"

-- @code end