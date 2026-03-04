-- Created by Ayush Biswas at 2026/03/03 18:33
-- https://cses.fi/problemset/task/1071

-- @code begin
import Control.Monad (replicateM)

getInts :: IO [Int]
getInts = map read . words <$> getLine

sol :: [Int] -> Int
sol [x, y]
  | even n = k + x - y
  | odd n = k + y - x
  where
    n = max x y
    k = n ^ 2 - n + 1

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  res <- replicateM n (sol <$> getInts)
  mapM_ print res

-- @code end