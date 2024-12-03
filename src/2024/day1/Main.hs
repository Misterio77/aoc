import Data.List (sort, transpose)

readIDLists :: String -> ([Int], [Int])
readIDLists = (\[x, y] -> (x, y)) . map (map read) . transpose . map words . lines

part1 :: [Int] -> [Int] -> Int
part1 x y = sum $ map abs $ zipWith (-) (sort x) (sort y)

-- Returns a list of occurences each element in "needles" has in "haystack"
occurences :: [Int] -> [Int] -> [Int]
occurences needles haystack = map (\needle -> length $ filter (== needle) haystack) needles

part2 :: [Int] -> [Int] -> Int
part2 x y = sum $ zipWith (*) x (occurences x y)

main :: IO ()
main = do
  (list1, list2) <- readIDLists <$> getContents
  print $ part1 list1 list2
  print $ part2 list1 list2
