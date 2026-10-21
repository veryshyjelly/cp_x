-- Created by Ayush Biswas at 2026/03/08 14:24
-- https://cses.fi/problemset/task/3399

-- @code begin

import Control.Monad (replicateM)
import Text.Printf (printf)

raab :: [Int] -> IO ()
raab [n, a, b]
  | (a == 0 || b == 0) && (m /= 0) = putStrLn "NO"
  | a + b == 1 = putStrLn "NO"
  | a + b > n = putStrLn "NO"
  | otherwise = do
      putStrLn "YES"
      mapM_ (printf "%d ") [1 .. n]
      printf "\n"
      mapM_ (printf "%d ") ([a + 1 .. m] ++ [1 .. a] ++ [m + 1 .. n])
      printf "\n"
  where
    m = a + b

getInts :: IO [Int]
getInts = map read . words <$> getLine

main :: IO ()
main = do
  t :: Int <- read <$> getLine
  nabs :: [[Int]] <- replicateM t getInts
  mapM_ raab nabs

-- @code end