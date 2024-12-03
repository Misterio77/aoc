import Instruction qualified (execute, fromString)

part1 :: String -> Int
part1 input = Instruction.execute (Instruction.fromString input False)

part2 :: String -> Int
part2 input = Instruction.execute (Instruction.fromString input True)

main :: IO ()
main = do
  input <- getContents
  print $ part1 input
  print $ part2 input
