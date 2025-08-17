import Foundation

@main
struct Exercise02 {
  static func main() {
    let inputChars = getInputChars()
    let numOfPositions = getNumOfPositions(directions: inputChars, entities: 2)

    assert(numOfPositions == 2360, "Invalid numOfPositions: \(numOfPositions)")
  }
}
