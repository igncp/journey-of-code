import Foundation

@main
struct Tests {
  static func g(s: String) -> [String] {
    return s.map { String($0) }
  }

  static func testGetFloorNumber() {
    let testCases: [(String, Int, Int)] = [
      (">", 1, 2),
      ("^>v<", 2, 3),
      ("^v^v^v^v^v", 2, 11),
    ]

    for (input, entities, expected) in testCases {
      let inputChars = g(s: input)
      let result = getNumOfPositions(directions: inputChars, entities: entities)
      assert(
        result == expected,
        "Expected \(expected), got \(result), for input \(input) with \(entities) entities")
    }
  }

  static func main() {
    testGetFloorNumber()
  }
}
