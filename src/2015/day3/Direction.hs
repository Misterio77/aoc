module Direction where

data Direction = North | South | East | West

fromChar :: Char -> Maybe Direction
fromChar '^' = Just North
fromChar 'v' = Just South
fromChar '>' = Just East
fromChar '<' = Just West
fromChar _ = Nothing
