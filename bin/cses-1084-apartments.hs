-- Created by Ayush Biswas at 2026/03/14 10:38
-- https://cses.fi/problemset/task/1084
-- Apartments

-- @code begin
{-# LANGUAGE BangPatterns #-}
import qualified Data.ByteString.Char8 as BS
import Data.Maybe (mapMaybe)
import Data.List (sort)
import Data.Array.Unboxed (UArray, listArray, (!))

main :: IO ()
main = do
  contents <- BS.getContents
  let allNums = mapMaybe (fmap fst . BS.readInt) (BS.words contents)
  case allNums of
    (n : m : k : rest) -> do
      let (desiredRaw, rest') = splitAt n rest
          actualRaw           = take m rest'

          -- Sort the lists, then pack them into unboxed arrays for O(1) indexing
          desired = listArray (0, n - 1) (sort desiredRaw) :: UArray Int Int
          actual  = listArray (0, m - 1) (sort actualRaw)  :: UArray Int Int

      print (match desired actual k n m)
    _ -> return ()

match :: UArray Int Int -> UArray Int Int -> Int -> Int -> Int -> Int
match ds as k nd na = loop 0 0 0
  where
    -- The standard `go` (or `loop`) idiom for a tight tail-recursive loop.
    -- The arrays `ds` and `as` are captured from the outer scope.
    loop !i !j !acc
      | i >= nd || j >= na = acc
      | dx < ay - k        = loop (i + 1) j acc
      | ay < dx - k        = loop i (j + 1) acc
      | otherwise          = loop (i + 1) (j + 1) (acc + 1)
      where
        dx = ds ! i
        ay = as ! j
-- @code end
