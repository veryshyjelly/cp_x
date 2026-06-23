-- Created by Ayush Biswas at 2026/03/11 13:11
-- https://cses.fi/problemset/task/1743
-- @code begin
{-# LANGUAGE LambdaCase #-}

import Control.Monad (forM_)
import Data.Array.IO

type Arr = IOUArray Char Int

-- try A..Z in order, pick first char that keeps state feasible
pickBest :: Arr -> Maybe Char -> Int -> IO (Maybe Char)
pickBest arr prev total = go ['A' .. 'Z']
  where
    limit = total `div` 2
    go [] = return Nothing
    go (c : cs) = do
      f <- readArray arr c
      if f == 0 || Just c == prev
        then go cs
        else do
          -- only f[c] changes, check it and all others against limit
          ok <- allUnder arr c (f - 1) limit
          if ok then return (Just c) else go cs

allUnder :: Arr -> Char -> Int -> Int -> IO Bool
allUnder arr changed newF limit
  | newF > limit = return False
  | otherwise = go ['A' .. 'Z']
  where
    go [] = return True
    go (c : cs) = do
      f <- if c == changed then return newF else readArray arr c
      if f > limit then return False else go cs

solve :: Arr -> Maybe Char -> String -> IO String
solve arr prev acc = do
  total <- sum <$> getElems arr
  if total == 0
    then return (reverse acc)
    else
      pickBest arr prev total >>= \case
        Nothing -> return "-1"
        Just c -> do
          modifyArray arr c (subtract 1)
          solve arr (Just c) (c : acc)

main :: IO ()
main = do
  s <- getLine
  arr <- newArray ('A', 'Z') 0 :: IO (IOUArray Char Int)
  forM_ s $ \c -> modifyArray arr c (+ 1)
  solve arr Nothing [] >>= putStrLn

-- @code end