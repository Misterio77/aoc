module Main where

import Data.List (mapAccumL, nub)
import Data.Maybe (mapMaybe)
import Direction (Direction (East, North, South, West))
import Direction qualified

type House = (Int, Int)

-- Filter a list by applying a predicate to its index
filterIdx :: (Int -> Bool) -> [a] -> [a]
filterIdx p xs = [x | (x, i) <- zip xs [0 ..], p i]

-- Given a location and a direction, return next  location
visitHouse :: House -> Direction -> House
visitHouse (x, y) East = (x + 1, y)
visitHouse (x, y) North = (x, y + 1)
visitHouse (x, y) South = (x, y - 1)
visitHouse (x, y) West = (x - 1, y)

-- Given a list of directions, return visited locations
visitHouses :: [Direction] -> [House]
visitHouses = foldl (\ps d -> visitHouse (head ps) d : ps) [(0, 0)]

-- Given a list of directions, return amount of unique positions visited
part1 :: [Direction] -> Int
part1 d = length $ nub $ visitHouses d

-- Given a list of directions, return amount of unique positions visited by alternating visitors
part2 :: [Direction] -> Int
part2 d = length $ nub $ visitHouses (filterIdx even d) ++ visitHouses (filterIdx odd d)

main = do
  directions <- mapMaybe Direction.fromChar <$> getContents
  print $ part1 directions
  print $ part2 directions
