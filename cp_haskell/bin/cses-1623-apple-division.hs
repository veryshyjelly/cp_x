-- Created by Ayush Biswas at 2026/03/08 10:47
-- https://cses.fi/problemset/task/1623

-- @code begin

minDivision [] target acc = abs (target - 2 * acc)
minDivision (x : xs) target acc =
  min (minDivision xs target (acc + x)) (minDivision xs target acc)

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  p :: [Int] <- map read . words <$> getLine
  let total = sum p
  let res = minDivision p total 0
  print res

-- @code end