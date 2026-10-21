-- Created by Ayush Biswas at 2026/03/03 15:37
-- https://cses.fi/problemset/task/1083

-- @code begin
import Data.Bits (Bits (xor))

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  a :: [Int] <- map read . words <$> getLine
  let res = foldl1 xor a `xor` foldl1 xor [1 .. n]
  print res

-- @code end