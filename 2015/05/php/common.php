<?php

declare(strict_types=1);

function get_input_content()
{
    $input = file_get_contents('../input.txt');
    $input = explode("\n", trim($input));
    return $input;
}

function check_model1(string $s)
{
    $vowels = [ "a" => true, "e" => true, "i" => true, "o" => true, "u" => true ];
    $minVowelsCount = 3;
    $minDoubleLetters = 1;
    $forbiddenSubstrings = [ "ab" => true, "cd" => true, "pq" => true, "xy" => true ];

    $vowelsCount = 0;
    $doubleLetters = 0;
    $prevChar = null;
    $errors = [];

    $chars = preg_split('//u', $s, -1, PREG_SPLIT_NO_EMPTY);
    foreach ($chars as $c) {
        if (isset($vowels[$c])) {
            $vowelsCount++;
        }

        if ($prevChar !== null) {
            if ($prevChar === $c) {
                $doubleLetters++;
            }
            $pair = $prevChar . $c;
            if (isset($forbiddenSubstrings[$pair])) {
                $errors[] = "ContainsForbiddenSubstring";
            }
        }
        $prevChar = $c;
    }

    if ($vowelsCount < $minVowelsCount) {
        $errors[] = "NotEnoughVowels";
    }
    if ($doubleLetters < $minDoubleLetters) {
        $errors[] = "NoDoubleLetters";
    }
    if (!empty($errors)) {
        return [ "result" => "Naughty", "reasons" => $errors ];
    }

    return [ "result" => "Nice" ];
}

function check_model2(string $s)
{
    $minNoOverlappingPairs = 2;
    $prevChar = null;
    $prevPrevChar = null;

    $pairs = [];
    $chars = preg_split('//u', $s, -1, PREG_SPLIT_NO_EMPTY);
    $hasRepeatingWithOneBetween = false;
    $hasPairAppearingTwice = false;
    $currentPos = 0;
    $errors = [];

    foreach ($chars as $c) {
        if ($prevPrevChar !== null && $prevPrevChar === $c) {
            $hasRepeatingWithOneBetween = true;
        }

        if ($prevChar !== null) {
            $pair = $prevChar . $c;
            if (!isset($pairs[$pair])) {
                $pairs[$pair] = [];
            }
            $pairs[$pair][] = $currentPos - 1;
        }

        $prevPrevChar = $prevChar;
        $prevChar = $c;
        $currentPos++;
    }

    if (!$hasRepeatingWithOneBetween) {
        $errors[] = "NoLetterRepeatingWithOneBetween";
    }

    if (!empty($pairs)) {
        foreach ($pairs as $indices) {
            if (count($indices) >= $minNoOverlappingPairs) {
                for ($i = 0; $i < count($indices) - 1; $i++) {
                    if ($indices[$i + 1] - $indices[$i] > 1) {
                        $hasPairAppearingTwice = true;
                        break 2;
                    }
                }
            }
        }
    }

    if (!$hasPairAppearingTwice) {
        $errors[] = "NoPairAppearingTwice";
    }
    if (!empty($errors)) {
        return [ "result" => "Naughty", "reasons" => $errors ];
    }
    return [ "result" => "Nice" ];
}
