#![allow(unused_imports)]
#![allow(warnings, unused)]
#![allow(dead_code)]

#[macro_use]
extern crate nom;

use nom::{
    bytes::complete::{tag, take_while_m_n},
    combinator::map,
    combinator::map_res,
    sequence::tuple,
    IResult,
};

use std::fs;
use nom::error::ErrorKind;
use nom::sequence::delimited;
use nom::sequence::preceded;
use nom::character::complete::multispace0;
use nom::branch::alt;
use nom::bytes::complete::take_till;
use nom::bytes::complete::take_while;
use nom::bytes::complete::take_while1;
use nom::character::complete::anychar;
use nom::character::complete::char;
use nom::character::complete::line_ending;
use nom::character::is_alphabetic;
use nom::sequence::terminated;
use nom::character::complete::not_line_ending;
use nom::combinator::not;
use nom::multi::fold_many0;
use nom::multi::many0;
use nom::multi::many1;
use nom::character::complete::digit1;
use nom::number::complete::be_u64;
use std::str::from_utf8_unchecked;
use nom::number::complete::double;
use nom::character::complete::hex_digit1;
use nom::combinator::peek;

#[derive(Debug)]
enum Constant<'a> {
    UInt(u64),
    Dec(f64),
    Hex(&'a str),
    Bin(Vec<char>),
    Str(&'a str),
    Bool(bool),
}

#[derive(Debug)]
enum SExp<'a> {
    Generic(Vec<SExp<'a>>),
    Constant(Constant<'a>),
    Symbol(&'a str),
}

fn integer(s: &str) -> IResult<&str, u64> {
    let inner = |(sn, _peek): (&str, ())| {
        sn.parse::<u64>().unwrap()
    };
    map(tuple((digit1, peek(not(char('.'))))), inner)(s)
}

fn decimal(s: &str) -> IResult<&str, f64> {
    double(s)
}

fn hex(s: &str) -> IResult<&str, &str> {
    map(tuple((tag("#x"), hex_digit1)),|(_, h)| h)(s)
}

fn bin(s: &str) -> IResult<&str, Vec<char>> {
    // Fn doesn't implement clone for some reason
    let bstring_orig = many1(alt((char('0'), char('1'))));
    let bstring_clne = many1(alt((char('0'), char('1'))));

    alt((
        bstring_orig,
        map(tuple((tag("#b"), bstring_clne)), |(_, b)| b)
    ))(s)
}

fn not_quote(s: &str) -> IResult<&str, &str> {
    take_while(|c| c != '"')(s)
}

fn string(s: &str) -> IResult<&str, &str> {
    map(tuple((char('"'), not_quote, char('"'))), |(_, sout, _)| sout)(s)
}

fn constant(s: &str) -> IResult<&str, Constant> {
    alt((
        map(integer, |i| Constant::UInt(i)),
        map(decimal, |d| Constant::Dec(d)),
        map(hex,     |h| Constant::Hex(h)),
        map(bin,     |b| Constant::Bin(b)),
        map(string,  |s| Constant::Str(s)),
    ))(s)
}

fn symbol(s: &str) -> IResult<&str, &str> {
    take_while1(|c : char| !c.is_whitespace() && !(c=='(') && !(c ==')'))(s)
}

fn sexp(s: &str) -> IResult<&str, SExp> {
    let rec_sexp = delimited(char('('), many1(sexp), char(')'));
    let ws_rec_sexp = delimited(multispace0, rec_sexp, multispace0);
    let ws_constant = delimited(multispace0, constant, multispace0);
    let ws_symbol = delimited(multispace0, symbol, multispace0);
    alt((
        map(ws_rec_sexp, |e| SExp::Generic(e)),
        map(ws_constant, |c| SExp::Constant(c)),
        map(ws_symbol,   |s| SExp::Symbol(s)),
    ))(s)
}

#[derive(Debug)]
enum Command<'a> {
    Logic(),
    CheckSat(),
    CheckSatAssuming(SExp<'a>),
    Assert(SExp<'a>),
    GetModel(),
    DeclConst(&'a str, Sort<'a>),
    Generic(&'a str),
}

#[derive(Debug)]
enum Sort<'a> {
    UInt(),
    Dec(),
    Str(),
    Bool(),
    Hex(),
    Bin(),
    BitVec(),
    Array(),
    UserDef(&'a str),
    Compound(Vec<Sort<'a>>),
}

fn sort(s: &str) -> IResult<&str, Sort> {
    let ws_int = delimited(multispace0, tag("Int"), multispace0);
    let ws_dec = delimited(multispace0, tag("Real"), multispace0);
    let ws_userdef = delimited(multispace0, symbol, multispace0);
    let rec_sort = delimited(char('('), many1(sort), char(')'));
    let ws_rec_sort = delimited(multispace0, rec_sort, multispace0);
    alt((
        map(ws_int, |_| Sort::UInt()),
        map(ws_dec, |_| Sort::Dec()),
        map(ws_userdef, |s| Sort::UserDef(s)),
        map(ws_rec_sort, |s| Sort::Compound(s)),
    ))(s)
}

fn decl_const(s: &str) -> IResult<&str, (&str, Sort)> {
    let ws_decl = delimited(multispace0, tag("decl-const"), multispace0);
    let ws_symbol = delimited(multispace0, symbol, multispace0);
    let ws_sort = delimited(multispace0, sort, multispace0);
    let inner = preceded(ws_decl, tuple((ws_symbol, ws_sort)));
    delimited(char('('), inner, char(')'))(s)
}

fn assert(s: &str) -> IResult<&str, SExp> {
    let ws_atag = delimited(multispace0, tag("assert"), multispace0);
    let ws_sexp = delimited(multispace0, sexp, multispace0);
    delimited(char('('), preceded(ws_atag, ws_sexp), char(')'))(s)
}

fn check_sat_assuming(s: &str) -> IResult<&str, SExp> {
    let ws_csatag = delimited(multispace0, tag("check-sat-assuming"), multispace0);
    let ws_sexp = delimited(multispace0, sexp, multispace0);
    delimited(char('('), preceded(ws_csatag, ws_sexp), char(')'))(s)
}

fn command(s: &str) -> IResult<&str, Command> {
    let ws_checksat = delimited(multispace0,tag("check-sat"), multispace0);
    let ws_csa = delimited(multispace0, check_sat_assuming, multispace0);
    let ws_getmodel = delimited(multispace0, tag("get-model"), multispace0);
    let ws_setlogic = delimited(multispace0, tag("set-logic"), multispace0);
    let ws_declconst = delimited(multispace0, decl_const, multispace0);
    let ws_assert = delimited(multispace0, assert, multispace0);
    alt((
        map(ws_assert,    |a| Command::Assert(a)),
        map(ws_csa,       |a| Command::CheckSatAssuming(a)),
        map(ws_checksat,  |_| Command::CheckSat()),
        map(ws_getmodel,  |_| Command::GetModel()),
        map(ws_setlogic,  |_| Command::Logic()),
        map(ws_declconst, |(v, s)| Command::DeclConst(v, s)),
    ))(s)
}


fn script(s: &str) -> IResult<&str, Vec<Command>> {
    many0(command)(s)
}


pub fn exec() {
    let files = fs::read_dir("samples").expect("error with sample dir");

    for file_res in files {
        let file = file_res.expect("problem with file");
        let filepath = file.path();
        println!("starting file {:?}", filepath);
        let contents = &fs::read_to_string(filepath).expect("error reading file")[..];
        match script(contents) {
            Ok(_) => (),
            Err(e) => panic!("SMT Parse Error {}", e),
        }
    }
}


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn smoke_test() {
        exec();
    }
}
