-- Created by Ayush Biswas at 2026/03/04 10:39
-- https://cses.fi/problemset/task/1755

-- @code begin

import Data.List
import Data.Map.Strict qualified as Map

main :: IO ()
main = do
  s <- getLine -- fast input
  let freq = Map.fromListWith (+) $ (,1) <$> s
      (evens, odds) = partition (even . snd) $ Map.toList freq
  if length odds > 1
    then putStrLn "NO SOLUTION"
    else do
      let bothSide = concatMap halfList evens
          middle = if length odds == 1 then expand (head odds) else []
          result = bothSide ++ middle ++ reverse bothSide
      putStrLn result
  where
    expand (x, len) = replicate len x
    halfList (x, len) = replicate (len `div` 2) x

-- @code end