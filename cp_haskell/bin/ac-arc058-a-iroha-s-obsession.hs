-- Created by Ayush Biswas at 2026/03/01 12:10
-- https://atcoder.jp/contests/abc042/tasks/arc058_a
-- @code begin
import Data.List
import Data.Set (Set)
import Data.Set qualified as Set

getNums :: IO [Int]
getNums = map read . words <$> getLine

main :: IO ()
main = do
  [n, k] <- getNums
  ds <- Set.fromList <$> getNums
  let Just res = find (isAcceptable ds) [n ..]
  print res

digits :: Int -> [Int]
digits 0 = []
digits n = (n `rem` 10) : digits (n `div` 10)

isAcceptable :: Set Int -> Int -> Bool
isAcceptable ds n = not $ any (`elem` ds) ns
  where
    ns = digits n

-- @code end