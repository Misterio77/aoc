module Main where

parenthesisToInt '(' = 1
parenthesisToInt ')' = -1
parenthesisToInt _ = 0

main = print . sum . map parenthesisToInt =<< getContents

