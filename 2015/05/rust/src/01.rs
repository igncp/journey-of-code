use rust::{StringCheckResult, check_string_model1, read_input};

fn main() {
    let input = read_input();
    let mut nice_count = 0;

    for line in input.lines() {
        if check_string_model1(line) == StringCheckResult::Nice {
            nice_count += 1
        }
    }

    assert_eq!(nice_count, 258);
}
