-- Created by Ayush Biswas at 2026/03/08 11:12
-- https://cses.fi/problemset/task/1624

-- @code begin

import Control.Monad (replicateM)
import Data.Set qualified as Set

data ChessBoard = ChessBoard
  { blocked :: Set.Set (Int, Int),
    column :: Set.Set Int,
    diag1 :: Set.Set Int,
    diag2 :: Set.Set Int
  }

newBoard :: [[Char]] -> ChessBoard
newBoard bd =
  ChessBoard
    { blocked = Set.fromList bl,
      column = Set.empty,
      diag1 = Set.empty,
      diag2 = Set.empty
    }
  where
    bl :: [(Int, Int)] =
      concat $
        zipWith
          (\i ls -> (i,) <$> ls)
          [1 ..]
          (map fst . filter (\(_, y) -> y == '*') . zip [1 ..] <$> bd)

isAvailable :: (Int, Int) -> ChessBoard -> Bool
isAvailable (i, j) board = and [notBlocked, notColOcc, notDiag1Occ, notDiag2Occ]
  where
    notBlocked = (i, j) `Set.notMember` blocked board
    notColOcc = j `Set.notMember` column board
    notDiag1Occ = (i + j) `Set.notMember` diag1 board
    notDiag2Occ = (i - j) `Set.notMember` diag2 board

putCell :: (Int, Int) -> ChessBoard -> ChessBoard
putCell (i, j) board = board {column = newCol, diag1 = newDiag1, diag2 = newDiag2}
  where
    newCol = Set.insert j $ column board
    newDiag1 = Set.insert (i + j) $ diag1 board
    newDiag2 = Set.insert (i - j) $ diag2 board

queens :: Int -> ChessBoard -> Int
queens 9 _ = 1
queens row board = sum $ queens (row + 1) <$> nextBoards
  where
    cells :: [(Int, Int)] =
      filter (`isAvailable` board) ((row,) <$> [1 .. 8])

    nextBoards = putCell <$> cells <*> [board]

main :: IO ()
main = do
  board <- newBoard <$> replicateM 8 getLine
  let res = queens 1 board
  print res

-- @code end