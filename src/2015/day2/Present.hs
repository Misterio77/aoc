module Present where

import Data.List.Split (splitOn)

data Present = Present Int Int Int

fromString :: String -> Present
fromString input = Present (read x :: Int) (read y :: Int) (read z :: Int)
  where
    [x, y, z] = splitOn "x" input

requiredPaper :: Present -> Int
requiredPaper (Present l w h) = side1 * 2 + side2 * 2 + side3 * 2 + smallest
  where
    side1 = l * w
    side2 = w * h
    side3 = h * l
    smallest = minimum [side1, side2, side3]

requiredRibbon :: Present -> Int
requiredRibbon (Present l w h) = smallest + volume
  where
    distance1 = 2*l + 2*w
    distance2 = 2*w + 2*h
    distance3 = 2*h + 2*l
    smallest = minimum [distance1, distance2, distance3]
    volume = l*w*h
