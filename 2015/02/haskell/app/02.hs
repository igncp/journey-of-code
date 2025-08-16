import Common (parseLine, sortTuple3, sortTuples, convertToWrapping, convertToRibbon)
import System.Exit (exitFailure, exitSuccess)

main :: IO ()
main = do
    input <- readFile "../input.txt"
    let inputLines = lines input
        nonEmptyLines = filter (not . null) inputLines
        parsedLines = map parseLine nonEmptyLines
        sortedLines = sortTuples parsedLines
        totalRibbon = sum $ map convertToRibbon sortedLines
    if totalRibbon == 3812909
      then exitSuccess
      else do
        putStrLn $ "Total wrapping paper needed is incorrect: " ++ show totalRibbon
        exitFailure
