deleteAt idx xs = lft ++ rgt
  where (lft, _:rgt) = splitAt idx xs

-- Returns all possibilities of list with one element removed
oneRemoved :: [Int] -> [[Int]]
oneRemoved xs = map (`deleteAt` xs) [0..length xs-1]

getInputReports :: String -> [[Int]]
getInputReports = map (map read . words) . lines

isSafe :: [Int] -> Bool
isSafe report
  | all (`elem` [1, 2, 3]) changes = True
  | all (`elem` [-1, -2, -3]) changes = True
  | otherwise = False
  where
    changes = zipWith (-) (init report) (tail report)

isAlmostSafe :: [Int] -> Bool
isAlmostSafe report = any isSafe (oneRemoved report)

part1 :: [[Int]] -> Int
part1 = length . filter isSafe

part2 :: [[Int]] -> Int
part2 = length . filter isAlmostSafe

main :: IO ()
main = do
  reports <- getInputReports <$> getContents
  print $ map oneRemoved reports
  print $ part1 reports
  print $ part2 reports