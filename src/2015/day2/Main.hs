module Main where

import Present (Present)
import Present qualified

part1 :: [Present] -> Int
part1 = sum . map Present.requiredPaper

part2 :: [Present] -> Int
part2 = sum . map Present.requiredRibbon

main :: IO ()
main = do
  presents <- map Present.fromString . lines <$> getContents
  print $ part1 presents
  print $ part2 presents
