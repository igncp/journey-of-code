use std::collections::{HashMap, HashSet};

#[derive(Debug, PartialEq, Eq, Hash)]
pub enum NaughtyReasonModel1 {
    NotEnoughVowels,
    NoDoubleLetters,
    ContainsForbiddenSubstring,
}

#[derive(Debug, PartialEq, Eq, Hash)]
pub enum NaughtyReasonModel2 {
    NoPairAppearingTwice,
    NoLetterRepeatingWithOneBetween,
}

#[derive(Debug, PartialEq, Eq)]
pub enum StringCheckResult<Reason: PartialEq + Eq + std::hash::Hash> {
    Nice,
    Naughty(HashSet<Reason>),
}

pub fn check_string_model1(s: &str) -> StringCheckResult<NaughtyReasonModel1> {
    let vowels = HashSet::from(['a', 'e', 'i', 'o', 'u']);
    let min_vowels_count = 3;
    let min_double_letters = 1;
    let forbidden_substrings = HashSet::from(["ab", "cd", "pq", "xy"]);

    let mut vowels_count = 0;
    let mut double_letters = 0;
    let mut prev_char: Option<char> = None;

    let mut s_chars = s.chars();
    let mut errors = HashSet::new();

    loop {
        let Some(c) = s_chars.next() else {
            if vowels_count < min_vowels_count {
                errors.insert(NaughtyReasonModel1::NotEnoughVowels);
            }
            if double_letters < min_double_letters {
                errors.insert(NaughtyReasonModel1::NoDoubleLetters);
            }
            if !errors.is_empty() {
                return StringCheckResult::Naughty(errors);
            }
            return StringCheckResult::Nice;
        };

        if vowels.contains(&c) {
            vowels_count += 1;
        }

        if let Some(pc) = prev_char {
            if pc == c {
                double_letters += 1;
            }
            let pair = format!("{pc}{c}");
            if forbidden_substrings.contains(pair.as_str()) {
                errors.insert(NaughtyReasonModel1::ContainsForbiddenSubstring);
            }
        }
        prev_char = Some(c);
    }
}

pub fn check_string_model2(s: &str) -> StringCheckResult<NaughtyReasonModel2> {
    let min_no_overlapping_pairs = 2;

    let mut prev_char: Option<char> = None;
    let mut prev_prev_char: Option<char> = None;

    let mut pairs: HashMap<String, Vec<usize>> = HashMap::new();

    let mut s_chars = s.chars();
    let mut has_repeating_with_one_between = false;
    let mut current_pos = 0;
    let mut errors = HashSet::new();

    loop {
        let Some(c) = s_chars.next() else {
            let has_pair_appearing_twice = pairs.values().any(|indices| {
                indices.len() >= min_no_overlapping_pairs
                    && indices.windows(2).any(|w| w[1] - w[0] > 1)
            });

            if !has_pair_appearing_twice {
                errors.insert(NaughtyReasonModel2::NoPairAppearingTwice);
            }
            if !has_repeating_with_one_between {
                errors.insert(NaughtyReasonModel2::NoLetterRepeatingWithOneBetween);
            }
            if !errors.is_empty() {
                return StringCheckResult::Naughty(errors);
            }
            return StringCheckResult::Nice;
        };

        if let Some(ppc) = prev_prev_char {
            if ppc == c {
                has_repeating_with_one_between = true;
            }
        }

        if let Some(pc) = prev_char {
            let pair = format!("{pc}{c}");
            pairs.entry(pair).or_default().push(current_pos - 1);
        }

        prev_prev_char = prev_char;
        prev_char = Some(c);
        current_pos += 1;
    }
}

pub fn read_input() -> String {
    std::fs::read_to_string("../input.txt").expect("Failed to read input file")
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn example_1_cases() {
        assert_eq!(
            check_string_model1("ugknbfddgicrmopn"),
            StringCheckResult::Nice
        );
        assert_eq!(check_string_model1("aaa"), StringCheckResult::Nice);
        assert_eq!(
            check_string_model1("jchzalrnumimnmhp"),
            StringCheckResult::Naughty(HashSet::from([NaughtyReasonModel1::NoDoubleLetters]))
        );
        assert_eq!(
            check_string_model1("haegwjzuvuyypxyu"),
            StringCheckResult::Naughty(HashSet::from([
                NaughtyReasonModel1::ContainsForbiddenSubstring
            ]))
        );
        assert_eq!(
            check_string_model1("dvszwmarrgswjxmb"),
            StringCheckResult::Naughty(HashSet::from([NaughtyReasonModel1::NotEnoughVowels]))
        );
    }

    #[test]
    fn example_2_cases() {
        assert_eq!(
            check_string_model2("qjhvhtzxzqqjkmpb"),
            StringCheckResult::Nice
        );
        assert_eq!(check_string_model2("xxyxx"), StringCheckResult::Nice);
        assert_eq!(
            check_string_model2("uurcxstgmygtbstg"),
            StringCheckResult::Naughty(HashSet::from([
                NaughtyReasonModel2::NoLetterRepeatingWithOneBetween
            ]))
        );
        assert_eq!(
            check_string_model2("ieodomkazucvgmuy"),
            StringCheckResult::Naughty(HashSet::from([NaughtyReasonModel2::NoPairAppearingTwice]))
        );
    }
}
