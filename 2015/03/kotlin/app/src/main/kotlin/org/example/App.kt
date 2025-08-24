package org.example

class Point(
    var x: Int,
    var y: Int,
) {
    override fun toString(): String = "Point(x=$x, y=$y)"
}

class App {
    fun getInputDirections(): Array<String> {
        var inputFile = java.io.File("../input.txt")

        if (System.getProperty("user.dir").endsWith("app")) {
            inputFile = java.io.File("../../input.txt")
        }

        val inputText = inputFile.readText()
        return inputText.split("").toTypedArray()
    }

    fun getNumOfPositions(
        directions: Array<String>,
        entities: Int,
    ): Int {
        var points = mutableListOf<Point>()
        var visitedPositionsCount = mutableMapOf<String, Int>()

        for (i in 0 until entities) {
            var newPoint = Point(0, 0)
            points.add(newPoint)
            visitedPositionsCount[newPoint.toString()] = 1
        }

        var currentEntityIdx = 0
        for (direction in directions) {
            var currentPosition = points[currentEntityIdx]
            when (direction) {
                "^" -> currentPosition.y += 1
                "v" -> currentPosition.y -= 1
                "<" -> currentPosition.x -= 1
                ">" -> currentPosition.x += 1
            }
            visitedPositionsCount[currentPosition.toString()] =
                visitedPositionsCount.getOrDefault(currentPosition.toString(), 0) + 1
            currentEntityIdx = (currentEntityIdx + 1) % entities
        }

        return visitedPositionsCount.size
    }

    fun main(args: Array<String>) {
        if (args.isNotEmpty() && args[0] == "01") {
            val inputContent = getInputDirections()
            val numPositions = getNumOfPositions(inputContent, 1)

            assert(numPositions == 2592) { "Expected 2592, but got $numPositions" }
        } else if (args.isNotEmpty() && args[0] == "02") {
            val inputContent = getInputDirections()
            val numPositions = getNumOfPositions(inputContent, 2)

            assert(numPositions == 2360) { "Expected 2360, but got $numPositions" }
        } else {
            println("Unexpected argument. Please use '01' or '02'.")
        }
    }
}

fun main(args: Array<String>) {
    val app = App()
    app.main(args)
}
