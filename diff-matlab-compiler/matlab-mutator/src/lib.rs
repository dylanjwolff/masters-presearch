#![feature(box_syntax, box_patterns)]
use rand::Rng;
extern crate rand_xoshiro;
use rand_xoshiro::rand_core::SeedableRng;
extern crate regex;

#[cfg(test)]
extern crate quickcheck;
#[cfg(test)]
#[macro_use(quickcheck)]
extern crate quickcheck_macros;
#[cfg(test)]

pub fn flip_op<T: Rng>(_script_contents: String, _rng: &mut T) {}

pub fn find_candidate_indices(script_contents: String) -> Vec<usize> {
    let re = create_re(box CANDIDATES.iter());
    regex::Regex::new(&re);
    return vec![1];
}

fn to_re_char(c: char) -> String {
    match c {
        '*' => r"\*".to_string(),
        _ => c.to_string(),
    }
}

fn create_re(cs: Box<Iterator<Item = &char>>) -> String {
    (*cs).join('|');
    return "".to_string();
}
pub static CANDIDATES: [char; 1] = ['*'];

#[cfg(test)]
mod tests {
    use super::*;

    #[quickcheck]
    fn create_re_test(c: char) -> bool {
        let re = create_re(box CANDIDATES.iter());
        if CANDIDATES.contains(&c) {
            regex::Regex::new(&re)
                .unwrap()
                .find(&c.to_string())
                .unwrap()
                .start()
                == 0
        } else {
            true
        }
    }
    #[quickcheck]
    fn to_re_char_test(c: char) -> bool {
        let c_re = to_re_char(c);
        if CANDIDATES.contains(&c) {
            regex::Regex::new(&c_re)
                .unwrap()
                .find(&c.to_string())
                .unwrap()
                .start()
                == 0
        } else {
            true
        }
    }
    #[quickcheck]
    fn smoke_flip(sc: String) {
        let mut rng = rand_xoshiro::Xoshiro256Plus::seed_from_u64(9999);
        flip_op(sc, &mut rng);
    }

    #[quickcheck]
    fn smoke_find(sc: String) {
        find_candidate_indices(sc);
    }
}
