-- Created by Ayush Biswas at 2026/03/01 19:23
-- https://atcoder.jp/contests/abc044/tasks/abc044_a

-- @code begin
import Control.Monad (replicateM)

getInt :: IO Int
getInt = read <$> getLine

main :: IO ()
main = do
  [n, k, x, y] <- replicateM 4 getInt
  let res = (min n k * x) + max ((n - k) * y) 0
  print res

-- @code end