-- Created by Ayush Biswas at 2026/03/11 13:11
-- https://cses.fi/problemset/task/1743
-- String Reorder
--
-- @code begin
{-# LANGUAGE BangPatterns #-}
import qualified Data.ByteString.Char8 as BS
import Data.Array.Unboxed
import Data.Char (chr, ord)
import Data.List (foldl')

type Counts = UArray Int Int

freqOf :: BS.ByteString -> Counts
freqOf s = accumArray (+) 0 (0, 25) [(ord c - ord 'A', 1) | c <- BS.unpack s]

-- (maxVal, multiplicity of maxVal, second highest value)
maxStats :: Counts -> (Int, Int, Int)
maxStats counts = foldl' upd (0, 0, 0) (elems counts)
  where
    upd (m, mult, second) v
      | v > m      = (v, 1, m)
      | v == m     = (m, mult + 1, second)
      | v > second = (m, mult, v)
      | otherwise  = (m, mult, second)

ceilDiv2 :: Int -> Int
ceilDiv2 x = (x + 1) `div` 2

-- try candidates 'A'..'Z' in order; pick the first that keeps the rest feasible
nextChar :: Int -> Counts -> Int -> Maybe (Char, Counts, Int)
nextChar remaining counts prev = go 0
  where
    (m, mult, second) = maxStats counts
    limitAfter = ceilDiv2 (remaining - 1)

    go 26 = Nothing
    go i
      | i == prev || counts ! i == 0 = go (i + 1)
      | newMax <= limitAfter = Just (chr (i + ord 'A'), counts // [(i, counts ! i - 1)], i)
      | otherwise = go (i + 1)
      where
        newMax
          | counts ! i < m = m                        -- untouched, old max still stands
          | mult > 1       = m                         -- another letter still holds the max
          | otherwise      = max (m - 1) second         -- this was the unique max holder

solve :: BS.ByteString -> BS.ByteString
solve s
  | maxFreq > ceilDiv2 n = BS.pack "-1"
  | otherwise = fst (BS.unfoldrN n gen (counts0, -1 :: Int, n))
  where
    counts0 = freqOf s
    n = BS.length s
    (maxFreq, _, _) = maxStats counts0
    gen (counts, prev, remaining) = do
      (c, counts', best) <- nextChar remaining counts prev
      return (c, (counts', best, remaining - 1))

main :: IO ()
main = BS.getLine >>= BS.putStrLn . solve
-- @code end
