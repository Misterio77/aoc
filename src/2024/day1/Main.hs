import Data.List (sort, transpose)

-- Counts the number of occurences of "needle" in "haystack"
count :: (Eq a) => a -> [a] -> Int
count needle haystack = length $ filter (== needle) haystack

-- Converts a two element list into a tuple
tuplify2 :: [a] -> (a, a)
tuplify2 [x, y] = (x, y)

readIDLists :: String -> ([Int], [Int])
readIDLists = tuplify2 . map (map read) . transpose . map words . lines

part1 :: [Int] -> [Int] -> Int
part1 x y = sum $ map abs $ zipWith (-) (sort x) (sort y)

-- Returns a list of occurences each element in "needles" has in "haystack"
occurences :: [Int] -> [Int] -> [Int]
occurences needles haystack = map (`count` haystack) needles

part2 :: [Int] -> [Int] -> Int
part2 x y = sum $ zipWith (*) x (occurences x y)

main :: IO ()
main = do
  (list1, list2) <- readIDLists <$> getContents
  print $ part1 list1 list2
  print $ part2 list1 list2
