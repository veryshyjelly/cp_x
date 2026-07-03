-- Created by Ayush Biswas at 2026/03/01 20:00
-- https://atcoder.jp/contests/abc044/tasks/abc044_b

-- @code begin
import Data.List

main :: IO ()
main = do
  w <- getLine
  let res = all (even . length) $ group $ sort w
  putStrLn (if res then "Yes" else "No")

-- @code end