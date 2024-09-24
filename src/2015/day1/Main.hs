module Main where

parenthesisToInt :: Char -> Int
parenthesisToInt '(' = 1
parenthesisToInt ')' = -1
parenthesisToInt _ = 0

part1 :: String -> Int
part1 = sum . map parenthesisToInt

part2 :: String -> Int
part2 = fst . head . filter ((== -1) . snd) . zip [0 ..] . scanl (+) 0 . map parenthesisToInt

main :: IO ()
main = do
  input <- getContents
  print $ part1 input
  print $ part2 input
