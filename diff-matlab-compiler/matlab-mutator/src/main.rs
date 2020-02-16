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
                .help("Sets the level of verbosity")
                .takes_value(true),
        )
        .get_matches();

    let in_f = Path::new(matches.value_of("INPUT").unwrap());
    let maybe_out_f: Option<&Path> = matches.value_of("OUTPUT").map(|out_f| Path::new(out_f));
    let seed = matches
        .value_of("SEED")
        .unwrap_or("999")
        .parse::<u64>()
        .unwrap();

    // Gets a value for config if supplied by user, or defaults to "default.conf"
    let mut rng = rand_xoshiro::Xoshiro256Plus::seed_from_u64(seed);
    let new = matlab_mutator::flip_in_file(in_f, &mut rng, 1);

    match maybe_out_f {
        Some(out_f) => fs::write(out_f, new),
        _ => fs::write("out.m", new),
    }
    .unwrap();
}
