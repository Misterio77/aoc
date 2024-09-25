module Main where

import Data.List (nub)

visitHouse :: (Int, Int) -> Char -> (Int, Int)
visitHouse (x, y) 'v' = (x, y + 1)
visitHouse (x, y) '^' = (x, y - 1)
visitHouse (x, y) '>' = (x + 1, y)
visitHouse (x, y) '<' = (x - 1, y)
visitHouse (x, y) _ = (x, y)

visitHouses :: [Char] -> [(Int, Int)] -> [(Int, Int)]
visitHouses [] visited = visited
visitHouses (direction : directions) visited = visitHouses directions (new : visited)
  where
    new = visitHouse (head visited) direction

part1 :: String -> Int
part1 directions = length $ nub visited
  where
    visited = visitHouses directions [(0, 0)]

part2 :: String -> String
part2 = error "Not implemented"

main :: IO ()
main = do
  input <- getContents
  print $ part1 input

-- print $ part2 input
