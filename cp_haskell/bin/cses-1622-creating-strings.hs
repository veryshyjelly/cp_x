-- Created by Ayush Biswas at 2026/03/05 15:56
-- https://cses.fi/problemset/task/1622

-- @code begin
import Data.List (permutations)
import Data.Set qualified as Set

main :: IO ()
main = do
  s <- getLine
  let res = Set.fromList $ permutations s
  print $ length res
  mapM_ putStrLn res

-- @code end