-- Created by Ayush Biswas at 2026/03/02 02:01
-- https://atcoder.jp/contests/abc045/tasks/abc045_b

-- @code begin

import Control.Monad.State (State, execState, get, put)
import Data.Char (toUpper)

game :: State (Char, [[Char]]) Char
game = do
  st <- get
  let (player, [a, b, c]) = st
  let res = play player a b c
  case res of
    Just st' -> put st' *> game
    Nothing -> return player
  where
    play 'a' (x : xs) b c = Just (x, [xs, b, c])
    play 'b' a (x : xs) c = Just (x, [a, xs, c])
    play 'c' a b (x : xs) = Just (x, [a, b, xs])
    play _ _ _ _ = Nothing

main :: IO ()
main = do
  a <- getLine
  b <- getLine
  c <- getLine
  let res = fst $ execState game ('a', [a, b, c])
  putChar $ toUpper res

-- @code end