module Common where
import Data.List.Split (splitOn)
import Data.List (sortBy)

type Tuple3 = (Int, Int, Int)

parseLine :: String -> Tuple3
parseLine line =
    let parts = splitOn "x" line
    in case map read parts of
        [a, b, c] -> (a, b, c)
        _         -> error $ "Invalid line format: " ++ line

sortTuple3 :: Tuple3 -> Tuple3
sortTuple3 (a, b, c) =
    let sorted = [a, b, c]
    in (minimum sorted, sum sorted - minimum sorted - maximum sorted, maximum sorted)

sortTuples :: [Tuple3] -> [Tuple3]
sortTuples tuples =
    let sorted = map sortTuple3 tuples
    in sortBy (\(x1, y1, z1) (x2, y2, z2) -> compare (x1, y1, z1) (x2, y2, z2)) sorted

-- Assumes the tuple is sorted
convertToWrapping :: Tuple3 -> Int
convertToWrapping (a, b, c) =
    let side1 = a * b
        side2 = b * c
        side3 = c * a
        smallestSide = minimum [side1, side2, side3]
    in 2 * (side1 + side2 + side3) + smallestSide

convertToRibbon :: Tuple3 -> Int
convertToRibbon (a, b, c) =
    let perimeter = 2 * (a + b)
        volume = a * b * c
    in perimeter + volume
