-- Created by Ayush Biswas at 2026/03/03 15:43
-- https://cses.fi/problemset/task/1069

-- @code begin
import Data.List

main :: IO ()
main = do
  s <- getLine
  let g = maximum $ length <$> group s
  print g

-- @code end