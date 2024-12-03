module Instruction where

import Data.Maybe (mapMaybe)
import Text.Regex.TDFA (getAllTextMatches, getAllTextSubmatches, (=~))

data Instruction = Do | Dont | Mul (Int, Int) deriving (Show)

fromString :: String -> Bool -> [Instruction]
fromString input conditionalStatements = map parse (input =~ pattern)
  where
    pattern =
      if conditionalStatements
        then "(mul)\\(([0-9]{1,3}),([0-9]{1,3})\\)|(don't)\\(\\)|(do)\\(\\)"
        else "(mul)\\(([0-9]{1,3}),([0-9]{1,3})\\)"
    parse :: [String] -> Instruction
    parse (_ : "mul" : x : y : _) = Mul (read x, read y)
    parse (_ : _ : _ : _ : "don't" : _) = Dont
    parse (_ : _ : _ : _ : _ : "do" : _) = Do

execute :: [Instruction] -> Int
execute xs = execute' xs True
  where
    execute' :: [Instruction] -> Bool -> Int
    execute' [] _ = 0
    execute' (Do : xs) _ = execute' xs True
    execute' (Dont : xs) _ = execute' xs False
    execute' (Mul _ : xs) False = execute' xs False
    execute' (Mul (x, y) : xs) True = x * y + execute' xs True
