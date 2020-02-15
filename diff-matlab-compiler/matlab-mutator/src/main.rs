use rand::Rng;
extern crate rand_xoshiro;
use rand_xoshiro::rand_core::SeedableRng;
fn main() {
    let mut rng = rand_xoshiro::Xoshiro256Plus::seed_from_u64(999);
    println!(
        "{:?}",
        matlab_mutator::flip_ops("* * /".to_string(), &mut rng, 4)
    );
}
