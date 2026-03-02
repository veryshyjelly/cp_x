-- Created by Ayush Biswas at 2026/03/01 18:49
-- https://atcoder.jp/contests/abc043/tasks/arc059_b

-- @code begin

import Control.Applicative ((<|>))
import Data.List
import Text.Printf

scanTwos :: (Eq a) => [a] -> Maybe (Int, Int)
scanTwos [] = Nothing
scanTwos (x : y : xs) | x == y = Just (length xs + 1, length xs)
scanTwos (_ : xs) = scanTwos xs

scanThrees :: (Eq a) => [a] -> Maybe (Int, Int)
scanThrees [] = Nothing
scanThrees (x : _ : z : xs) | x == z = Just (length xs + 2, length xs)
scanThrees (_ : xs) = scanThrees xs

main :: IO ()
main = do
  s <- getLine
  let n = length s
  let Just (x, y) =
        (\(x, y) -> (n - x, n - y))
          <$> (scanTwos s <|> scanThrees s)
          <|> Just (-1, -1)
  printf "%d %d" x y

-- @code end
