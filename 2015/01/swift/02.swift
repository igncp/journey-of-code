import Foundation

@main
struct Exercise02 {
  static func main() {
    let inputChars = getInputChars()
    let position = getPositionOfFloor(targetFloor: -1, inputChars: inputChars)

    assert(position == 1771, "Invalid position: \(position)")
  }
}
