-- Created by Ayush Biswas at 2026/03/03 15:21
-- https://cses.fi/problemset/task/1068

-- @code begin

import Text.Printf (printf)

weird xs@(1 : _) = xs
weird xs@(x : _) | even x = weird $ (x `div` 2) : xs
weird xs@(x : _) | odd x = weird $ (x * 3 + 1) : xs

main :: IO ()
main = do
  n :: Int <- read <$> getLine
  let res = reverse $ weird [n]
  mapM_ (printf "%d ") res

-- @code end