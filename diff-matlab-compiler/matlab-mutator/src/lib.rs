use rand::Rng;
extern crate rand_xoshiro;
use rand_xoshiro::rand_core::SeedableRng;
extern crate log;
extern crate regex;
use regex::Match;

use log::info;
#[cfg(test)]
extern crate quickcheck;
#[cfg(test)]
#[macro_use(quickcheck)]
extern crate quickcheck_macros;
#[cfg(test)]

pub fn flip_op<T: Rng>(_script_contents: String, _rng: &mut T) {}

pub fn find_candidate_indices(script_contents: &String) -> Vec<Match> {
    let re = create_re(&CANDIDATES);
    let re = regex::Regex::new(&re).unwrap();

    re.find_iter(script_contents).collect()
}

fn to_re_char(c: char) -> String {
    match c {
        '*' => r"\*".to_string(),
        _ => c.to_string(),
    }
}

fn create_re(cs: &[char]) -> String {
    let re = cs
        .iter()
        .map(|c| to_re_char(*c))
        .collect::<Vec<String>>()
        .join("|");
    return re;
}
pub static CANDIDATES: [char; 3] = ['/', '*', '-'];

#[cfg(test)]
mod tests {
    use super::*;

    #[quickcheck]
    fn create_re_test(c: char) -> bool {
        let re = create_re(&CANDIDATES);
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
    fn find_gets_correct(sc: String) -> bool {
        find_candidate_indices(&sc)
            .iter()
            .all(|mat| CANDIDATES.contains(&mat.as_str().chars().nth(0).unwrap()))
    }
}
