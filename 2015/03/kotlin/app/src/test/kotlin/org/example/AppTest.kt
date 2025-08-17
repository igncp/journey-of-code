package org.example

import kotlin.test.Test
import kotlin.test.assertEquals

class AppTest {
  @Test
  fun example1() {
    val classUnderTest = App()

    assertEquals(2, classUnderTest.getNumOfPositions(">".split("").toTypedArray(), 1))
    assertEquals(3, classUnderTest.getNumOfPositions("^>v<".split("").toTypedArray(), 2))
    assertEquals(11, classUnderTest.getNumOfPositions("^v^v^v^v^v".split("").toTypedArray(), 2))
  }
}
