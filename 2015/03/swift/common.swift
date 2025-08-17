import Foundation

let file = "../input.txt"

func getInputChars() -> [String] {
  let fileURL = URL(
    fileURLWithPath: file,
    relativeTo: URL(fileURLWithPath: FileManager.default.currentDirectoryPath))

  do {
    let inputText = try String(contentsOf: fileURL, encoding: .utf8)
    return inputText.map { String($0) }
  } catch {
    print("Error reading file: \(error)")
    exit(1)
  }
}

struct Point: CustomStringConvertible {
  var x: Int
  var y: Int

  var description: String {
    return "(\(x), \(y))"
  }
}

func getNumOfPositions(directions: [String], entities: Int) -> Int {
  var points = Array(repeating: Point(x: 0, y: 0), count: entities)
  var visitedPositionsCount = [String: Int]()

  for point in points {
    visitedPositionsCount[point.description] = 1
  }

  var currentEntityIdx = 0
  for direction in directions {
    var currentPosition = points[currentEntityIdx]
    switch direction {
    case "^":
      currentPosition.y += 1
    case "v":
      currentPosition.y -= 1
    case "<":
      currentPosition.x -= 1
    case ">":
      currentPosition.x += 1
    default:
      continue
    }

    points[currentEntityIdx] = currentPosition
    visitedPositionsCount[currentPosition.description, default: 0] += 1
    currentEntityIdx = (currentEntityIdx + 1) % entities
  }

  return visitedPositionsCount.count
}
