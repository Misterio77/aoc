module Main where

vowelCount :: String -> Int
vowelCount = length . filter (`elem` "aeiou")

hasTwiceLetter :: String -> Bool
hasTwiceLetter _ = error "TODO"

hasBadStrings :: String -> Bool
hasBadStrings _ = error "TODO"

isNice :: String -> Bool
isNice s = vowelCount s >= 3 && hasTwiceLetter s && not (hasBadStrings s)

main :: IO ()
main = do
  input <- getContents
  print $ isNice input
