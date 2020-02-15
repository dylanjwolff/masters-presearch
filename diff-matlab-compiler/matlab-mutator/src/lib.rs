use rand::Rng;

pub fn flip_op<T: Rng>(script_contents: String, rng: T) {}

#[cfg(test)]
mod tests {
    extern crate quickcheck;
    #[macro_use(quickcheck)]
    extern crate quickcheck_macros;

    #[quickcheck]
    fn smoke(sc: String) {}
}
