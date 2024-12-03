module Instruction where

import Data.Maybe (mapMaybe)
import Text.Regex.TDFA ((=~))

data Instruction = Do | Dont | Mul (Int, Int) deriving (Show)

fromString :: String -> Bool -> [Instruction]
fromString input conditionalStatements = mapMaybe parse $ input =~ regexp
  where
    regexp =
      if conditionalStatements
        then "mul\\(([0-9]{1,3}),([0-9]{1,3})\\)|don't\\(\\)|do\\(\\)"
        else "mul\\(([0-9]{1,3}),([0-9]{1,3})\\)"
    parse :: [String] -> Maybe Instruction
    parse ("do()" : _) = Just Do
    parse ("don't()" : _) = Just Dont
    parse (_ : x : y : _) = Just $ Mul (read x, read y)
    parse _ = Nothing

execute :: [Instruction] -> Int
execute instructions = execute' instructions True
  where
    execute' :: [Instruction] -> Bool -> Int
    execute' [] _ = 0
    execute' (Do : xs) _ = execute' xs True
    execute' (Dont : xs) _ = execute' xs False
    execute' (Mul _ : xs) False = execute' xs False
    execute' (Mul (x, y) : xs) True = x * y + execute' xs True
