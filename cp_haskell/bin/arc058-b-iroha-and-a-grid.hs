-- Created by Ayush Biswas at 2026/03/01 13:16
-- https://atcoder.jp/contests/abc042/tasks/arc058_b

-- @code begin
import Data.Array (Array, array, (!))

m :: Integer
m = 10 ^ 9 + 7

size :: Integer
size = 2 * 10 ^ 5

powMod :: Integer -> Integer -> Integer -> Integer
powMod _ 0 _ = 1
powMod b e m
  | odd e = b * powMod b (e - 1) m `mod` m
  | otherwise = let x = powMod b (e `div` 2) m in x * x `mod` m

inv :: Integer -> Integer
inv a = powMod a (m - 2) m

factorial :: Array Integer Integer
factorial = array (0, size) ([(i, factorial' i `mod` m) | i <- [0 .. size]])
  where
    factorial' 0 = 1
    factorial' 1 = 1
    factorial' n = n * factorial ! (n - 1)

numWays :: Integer -> Integer -> Integer
numWays x y = factorial ! (x + y) * inv (factorial ! x) * inv (factorial ! y)

main :: IO ()
main = do
  [h, w, a, b] :: [Integer] <- map read . words <$> getLine
  let ways = sum $ (\j -> numWays (h - a - 1) (j - 1) * numWays (a - 1) (w - j)) <$> [b + 1 .. w]
  print (ways `mod` m)

-- @code end