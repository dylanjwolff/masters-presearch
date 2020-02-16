use rand::Rng;
extern crate rand_xoshiro;
use rand_xoshiro::rand_core::SeedableRng;
extern crate log;
extern crate regex;
use log::debug;
use rand::seq::IteratorRandom;
use regex::Match;
use std::fs;
use std::iter::repeat;
use std::path::Path;
#[cfg(test)]
extern crate quickcheck;
#[cfg(test)]
#[macro_use(quickcheck)]
extern crate quickcheck_macros;

pub fn flip_in_file<T: Rng>(in_f: &Path, rng: &mut T, num_to_flip: usize) -> String {
    let sc = fs::read_to_string(in_f).unwrap();
    flip_ops(sc, rng, num_to_flip)
}

pub fn flip_ops<T: Rng>(script_contents: String, rng: &mut T, num_to_flip: usize) -> String {
    let mats = find_candidate_indices(&script_contents);
    let mats_to_flip = mats.into_iter().choose_multiple(rng, num_to_flip);
    debug!("Flipping {} candidates", mats_to_flip.len());
    let repments = mats_to_flip
        .iter()
        .map(|mat| (mat, *CANDIDATES.iter().choose(rng).unwrap()))
        .collect();
    replace(script_contents.clone(), repments)
}

pub fn replace(sc: String, replacements: Vec<(&Match, char)>) -> String {
    let mut bytes = sc.into_bytes();

    for (mat, new) in replacements {
        let newb = new.to_string().into_bytes();
        bytes.splice(mat.range(), newb);
    }

    String::from_utf8(bytes).expect("Expected valid replacement string")
}

pub fn find_candidate_indices(script_contents: &String) -> Vec<Match> {
    let re = create_re(&CANDIDATES);
    let re = regex::Regex::new(&re).unwrap();

    let candidates: Vec<Match> = re.find_iter(script_contents).collect();
    debug!("Found {} candidates", candidates.len());
    return candidates;
}

fn to_re_char(c: char) -> String {
    match c {
        '*' => r"\*".to_string(),
        '+' => r"\+".to_string(),
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
pub static CANDIDATES: [char; 4] = ['/', '*', '-', '+'];

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
        flip_ops(sc, &mut rng, 2);
    }

    #[quickcheck]
    fn find_gets_correct(sc: String) -> bool {
        find_candidate_indices(&sc)
            .iter()
            .all(|mat| CANDIDATES.contains(&mat.as_str().chars().nth(0).unwrap()))
    }

    #[quickcheck]
    fn qc_replace(sc: String) {
        let c = '*';
        let mats = find_candidate_indices(&sc);
        let repments = mats.iter().zip(repeat(c)).collect();
        let news = replace(sc.clone(), repments);

        for mat in mats {
            let bv = news.bytes().collect::<Vec<u8>>();
            let repment = (&bv[mat.range()]).to_vec();
            let repment_str = String::from_utf8(repment).expect("Fail to get replacement in test!");
            assert!(repment_str == c.to_string());
        }
    }
}
