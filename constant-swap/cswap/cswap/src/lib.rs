#![allow(unused_imports)]
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

use nom::branch::alt;
use nom::bytes::complete::take_till;
use nom::bytes::complete::take_while;
use nom::character::complete::anychar;
use nom::character::complete::char;
use nom::character::complete::line_ending;
use nom::character::is_alphabetic;
use nom::sequence::terminated;

#[derive(Debug)]
enum S {
    QuotedSymbol(String),
}

#[derive(Debug)]
enum PS {
    PS_Not(),
    PS_Bool(),
    PS_ContinuedExecution(),
    PS_Error(),
    PS_False(),
    PS_ImmediateExit(),
    PS_Incomplete(),
    PS_Logic(),
    PS_Memout(),
    PS_Sat(),
    PS_Success(),
    PS_Theory(),
    PS_True(),
    PS_Unknown(),
    PS_Unsupported(),
    PS_Unsat(),
}

#[derive(Debug)]
enum CMD {
    CMD_Assert(),
    CMD_CheckSat(),
    CMD_CheckSatAssuming(),
    CMD_DeclareConst(),
    CMD_DeclareDatatype(),
    CMD_DeclareDatatypes(),
    CMD_DeclareFun(),
    CMD_DeclareSort(),
    CMD_DefineFun(),
    CMD_DefineFunRec(),
    CMD_DefineFunsRec(),
    CMD_DefineSort(),
    CMD_Echo(),
    CMD_Exit(),
    CMD_GetAssertions(),
    CMD_GetAssignment(),
    CMD_GetInfo(),
    CMD_GetModel(),
    CMD_GetOption(),
    CMD_GetProof(),
    CMD_GetUnsatAssumptions(),
    CMD_GetUnsatCore(),
    CMD_GetValue(),
    CMD_Pop(),
    CMD_Push(),
    CMD_Reset(),
    CMD_ResetAssertions(),
    CMD_SetInfo(),
    CMD_SetLogic(),
    CMD_SetOption(),
}

fn cmd(s: &str) -> IResult<&str, CMD> {
    alt((
        map(tag("assert"), |_| CMD::CMD_Assert()),
        map(tag("check-sat"), |_| CMD::CMD_CheckSat()),
        map(tag("check-sat-assuming"), |_| CMD::CMD_CheckSatAssuming()),
        map(tag("declare-const"), |_| CMD::CMD_DeclareConst()),
        map(tag("declare-datatype"), |_| CMD::CMD_DeclareDatatype()),
        map(tag("declare-datatypes"), |_| CMD::CMD_DeclareDatatypes()),
        map(tag("declare-fun"), |_| CMD::CMD_DeclareFun()),
        map(tag("declare-sort"), |_| CMD::CMD_DeclareSort()),
        map(tag("define-fun"), |_| CMD::CMD_DefineFun()),
        map(tag("define-fun-rec"), |_| CMD::CMD_DefineFunRec()),
        map(tag("define-funs-rec"), |_| CMD::CMD_DefineFunsRec()),
        map(tag("define-sort"), |_| CMD::CMD_DefineSort()),
        map(tag("echo"), |_| CMD::CMD_Echo()),
        map(tag("exit"), |_| CMD::CMD_Exit()),
        map(tag("get-assertions"), |_| CMD::CMD_GetAssertions()),
        map(tag("get-assignment"), |_| CMD::CMD_GetAssignment()),
        map(tag("get-info"), |_| CMD::CMD_GetInfo()),
        map(tag("get-model"), |_| CMD::CMD_GetModel()),
        map(tag("get-option"), |_| CMD::CMD_GetOption()),
        map(tag("get-proof"), |_| CMD::CMD_GetProof()),
        // I believe there is a size limitation for tuples that forces us to do this
        alt((
            map(tag("get-unsat-assumptions"), |_| {
                CMD::CMD_GetUnsatAssumptions()
            }),
            map(tag("get-unsat-core"), |_| CMD::CMD_GetUnsatCore()),
            map(tag("get-value"), |_| CMD::CMD_GetValue()),
            map(tag("pop"), |_| CMD::CMD_Pop()),
            map(tag("push"), |_| CMD::CMD_Push()),
            map(tag("reset"), |_| CMD::CMD_Reset()),
            map(tag("reset-assertions"), |_| CMD::CMD_ResetAssertions()),
            map(tag("set-info"), |_| CMD::CMD_SetInfo()),
            map(tag("set-logic"), |_| CMD::CMD_SetLogic()),
            map(tag("set-option"), |_| CMD::CMD_SetOption()),
        )),
    ))(s)
}

fn ps(s: &str) -> IResult<&str, PS> {
    alt((
        map(tag("not"), |_| PS::PS_Not()),
        map(tag("Bool"), |_| PS::PS_Bool()),
        map(tag("continued-execution"), |_| PS::PS_ContinuedExecution()),
        map(tag("error"), |_| PS::PS_Error()),
        map(tag("false"), |_| PS::PS_False()),
        map(tag("immediate-exit"), |_| PS::PS_ImmediateExit()),
        map(tag("incomplete"), |_| PS::PS_Incomplete()),
        map(tag("logic"), |_| PS::PS_Logic()),
        map(tag("memout"), |_| PS::PS_Memout()),
        map(tag("sat"), |_| PS::PS_Sat()),
        map(tag("success"), |_| PS::PS_Success()),
        map(tag("theory"), |_| PS::PS_Theory()),
        map(tag("true"), |_| PS::PS_True()),
        map(tag("unknown"), |_| PS::PS_Unknown()),
        map(tag("unsupported"), |_| PS::PS_Unsupported()),
        map(tag("unsat"), |_| PS::PS_Unsat()),
    ))(s)
}

fn nbs(s: &str) -> IResult<&str, &str> {
    take_while(|c| c != '\\' && c != '|')(s)
}

fn ns(s: &str) -> IResult<&str, &str> {
    take_while(|c| c != '"')(s)
}

fn qs(s: &str) -> IResult<&str, S> {
    map(tuple((char('|'), nbs, char('|'))), |(_, s, _)| {
        S::QuotedSymbol(s.to_string())
    })(s)
}

fn s(s: &str) -> IResult<&str, S> {
    map(tuple((char('"'), ns, char('"'))), |(_, s, _)| {
        S::QuotedSymbol(s.to_string())
    })(s)
}

enum AST {
    Node(),
}

fn hello_parser(i: &str) -> nom::IResult<&str, &str> {
    nom::bytes::complete::tag("hello")(i)
}

fn parser(i: &str) -> nom::IResult<&str, AST> {
    Ok(("", AST::Node()))
}
use nom::character::complete::not_line_ending;
use nom::combinator::not;
use nom::multi::fold_many0;
use nom::multi::many0;

fn crmv(s: &str) -> IResult<&str, &str> {
    let comment = map(
        tuple((char(';'), not_line_ending, line_ending)),
        |(_, _, _)| "",
    );
    alt((comment, take_while(|c| c != ';')))(s)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        println!("{:?}", crmv("test ; asdf\r\n"));
        println!("{:?}", qs("|hello|"));
        println!("{:?}", hello_parser("hello world"));
        println!("{:?}", hello_parser("goodbye hello again"));
    }
}
