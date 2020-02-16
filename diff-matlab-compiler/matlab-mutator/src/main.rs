use rand::Rng;
use std::fs;
use std::path::Path;

extern crate clap;
use clap::{App, Arg, SubCommand};
extern crate rand_xoshiro;
use rand_xoshiro::rand_core::SeedableRng;

fn main() {
    env_logger::init();

    let matches = App::new("My Super Program")
        .version("1.0")
        .author("Kevin K. <kbknapp@gmail.com>")
        .about("Does awesome things")
        .arg(
            Arg::with_name("INPUT")
                .short("i")
                .long("input")
                .value_name("FILE")
                .help("file to mutate")
                .takes_value(true)
                .required(true)
                .index(1),
        )
        .arg(
            Arg::with_name("OUTPUT")
                .short("o")
                .long("output")
                .takes_value(true)
                .help("Sets the output file to use"),
        )
        .arg(
            Arg::with_name("SEED")
                .short("s")
                .long("seed")
                .help("Seed for the RNG used to pick mutations")
                .takes_value(true),
        )
        .arg(
            Arg::with_name("NUM MUTATIONS")
                .short("n")
                .long("num-mutations")
                .help("Number of mutations to make in the file")
                .takes_value(true),
        )
        .get_matches();

    let in_f = Path::new(matches.value_of("INPUT").unwrap());
    let maybe_out_f: Option<&Path> = matches.value_of("OUTPUT").map(|out_f| Path::new(out_f));
    let num_mutations = matches
        .value_of("NUM MUTATIONS")
        .and_then(|n| n.parse::<usize>().ok())
        .unwrap_or(1);
    let seed = matches
        .value_of("SEED")
        .and_then(|n| n.parse::<u64>().ok())
        .unwrap_or(9999);

    // Gets a value for config if supplied by user, or defaults to "default.conf"
    let mut rng = rand_xoshiro::Xoshiro256Plus::seed_from_u64(seed);
    let new = matlab_mutator::flip_in_file(in_f, &mut rng, num_mutations);

    match maybe_out_f {
        Some(out_f) => fs::write(out_f, new),
        _ => {
            println!("{}", new);
            Ok(())
        }
    }
    .unwrap();
}
