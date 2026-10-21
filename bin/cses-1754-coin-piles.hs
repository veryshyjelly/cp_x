-- Created by Ayush Biswas at 2026/03/04 10:23
-- https://cses.fi/problemset/task/1754

-- @code begin

import Control.Monad (replicateM)

getInts :: IO [Int]
getInts = map read . words <$> getLine

sol :: (Integral a) => [a] -> String
sol [a, b]
  | a > 2 * b || b > 2 * a = "NO"
  | a == b && a `mod` 3 == 0 = "YES"
  | a == b && a `mod` 3 /= 0 = "NO"
  | a > b = sol [a - 2 * x, b - x]
  | a < b = sol [a - x, b - 2 * x]
  where
    x = abs (a - b)

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  abs <- replicateM n getInts
  let res = sol <$> abs
  mapM_ putStrLn res

-- @code end