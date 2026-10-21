-- Created by Ayush Biswas at 2026/03/01 14:57
-- https://atcoder.jp/contests/abc043/tasks/abc043_b

-- @code begin

import Control.Monad.State (State, execState, get, modify)

transform :: Char -> String -> String
transform 'B' [] = []
transform 'B' (_ : xs) = xs
transform c xs = c : xs

keyb :: Char -> State String ()
keyb c = do modify (transform c)

main :: IO ()
main = do
  s <- getLine
  putStrLn . reverse $ execState (mapM_ keyb s) []

-- @code end