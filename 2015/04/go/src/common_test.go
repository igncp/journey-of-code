package src

import (
	"testing"
)

func TestExample1(t *testing.T) {
	if GetNumberForPrefix("00000", "abcdef") != 609043 {
		t.Errorf("Expected 609043, got %d", GetNumberForPrefix("00000", "abcdef"))
	}
}

func TestExample2(t *testing.T) {
	if GetNumberForPrefix("00000", "pqrstuv") != 1048970 {
		t.Errorf("Expected 1048970, got %d", GetNumberForPrefix("00000", "pqrstuv"))
	}
}
