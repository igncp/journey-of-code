import Common (parseLine, sortTuple3, sortTuples, convertToWrapping)
import System.Exit (exitFailure, exitSuccess)

main :: IO ()
main = do
    input <- readFile "../input.txt"
    let inputLines = lines input
        nonEmptyLines = filter (not . null) inputLines
        parsedLines = map parseLine nonEmptyLines
        sortedLines = sortTuples parsedLines
        totalWrapping = sum $ map convertToWrapping sortedLines
    if totalWrapping == 1598415
      then exitSuccess
      else do
        putStrLn $ "Total wrapping paper needed is incorrect: " ++ show totalWrapping
        exitFailure
