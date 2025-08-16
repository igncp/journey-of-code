module Main where
import Test.HUnit
import Common (parseLine, sortTuple3, sortTuples, convertToWrapping, convertToRibbon)

testParseLine :: Test
testParseLine = TestCase (
    assertEqual ""
    (1, 2, 3) (parseLine "1x2x3")
  )

testSortTuple3 :: Test
testSortTuple3 = TestCase (
    assertEqual ""
    (1, 2, 3) (sortTuple3 (2, 3, 1))
  )

testSortTuples :: Test
testSortTuples = TestCase (
    assertEqual ""
    [(1, 2, 3), (4, 5, 6)] (sortTuples [(2, 3, 1), (5, 4, 6)])
  )

testWrappingExample1 :: Test
testWrappingExample1 = TestCase (
    assertEqual ""
    58 (convertToWrapping (2, 3, 4))
  )

testWrappingExample2 :: Test
testWrappingExample2 = TestCase (
    assertEqual ""
    43 (convertToWrapping (1, 1, 10))
  )

testRibbonExample1 :: Test
testRibbonExample1 = TestCase (
    assertEqual ""
    34 (convertToRibbon (2, 3, 4))
  )

testRibbonExample2 :: Test
testRibbonExample2 = TestCase (
    assertEqual ""
    14 (convertToRibbon (1, 1, 10))
  )

tests :: Test
tests = TestList [TestLabel "Parses Lines" testParseLine,
                  TestLabel "Sorts Tuple3" testSortTuple3,
                  TestLabel "Sorts Tuples" testSortTuples,
                  TestLabel "Wrapping Example 1" testWrappingExample1,
                  TestLabel "Wrapping Example 2" testWrappingExample2,
                  TestLabel "Ribbon Example 1" testRibbonExample1,
                  TestLabel "Ribbon Example 2" testRibbonExample2]

main :: IO ()
main = runTestTTAndExit tests
