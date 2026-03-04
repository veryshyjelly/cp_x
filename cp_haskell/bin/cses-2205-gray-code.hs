-- Created by Ayush Biswas at 2026/03/04 19:30
-- https://cses.fi/problemset/task/2205

-- @code begin

import Data.Bits (xor)
import Text.Printf (printf)

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  let res = (gray . binary n <$> [0 .. 2 ^ n - 1]) <*> [[]]
  mapM_ (\code -> mapM_ (printf "%d") code *> printf "\n") res
  where
    gray xs@(x : _) [] = gray xs [x]
    gray (x : y : xs) as = gray (y : xs) $ (x `xor` y) : as
    gray _ res = res

    binary :: Int -> Int -> [Int]
    binary n x = reverse $ (`mod` 2) <$> take n (iterate (`div` 2) x)

-- @code end