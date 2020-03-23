#![feature(try_blocks)]
#![allow(unused_imports)]

extern crate antlr_rust;
#[macro_use]
extern crate lazy_static;

pub mod smtlibv2lexer;
pub mod smtlibv2listener;
pub mod smtlibv2parser;

use crate::smtlibv2parser::CommandContext;
use crate::smtlibv2parser::IdentifierContext;
use crate::smtlibv2parser::NumeralContextAttrs;
use crate::smtlibv2parser::Qual_identiferContext;
use crate::smtlibv2parser::SimpleSymbolContext;
use crate::smtlibv2parser::Spec_constantContextAttrs;
use crate::smtlibv2parser::TermContext;
use crate::smtlibv2parser::TermContextAttrs;
use antlr_rust::common_token_stream::CommonTokenStream;
use antlr_rust::input_stream::InputStream;
use antlr_rust::parser_rule_context::{BaseParserRuleContext, ParserRuleContext};
use antlr_rust::token::OwningToken;
use antlr_rust::token::{TOKEN_DEFAULT_CHANNEL, TOKEN_MIN_USER_TOKEN_TYPE};
use antlr_rust::tree::TerminalNode;
use antlr_rust::tree::Tree;
use antlr_rust::tree::{ParseTree, ParseTreeListener, TerminalNodeCtx};
use smtlibv2lexer::SMTLIBv2Lexer;
use smtlibv2listener::SMTLIBv2Listener;
use smtlibv2parser::SMTLIBv2Parser;
use smtlibv2parser::SimpleSymbolContextAttrs;
use std::borrow::BorrowMut;
use std::collections::BTreeMap;
use std::rc::Rc;

const SMT_EX: &'static str = "(set-logic QF_LIA)
(declare-const x Int)
(declare-const y Int)
(assert (= (- x y) (+ (+ x (- y) 1) 4)))
(check-sat)
; unsat
(exit)";

const IN_EX: &'static str = "(declare-const x Int)";
const R_EX: &'static str = "x";

pub fn exec() {
    let mut _lexer = SMTLIBv2Lexer::new(Box::new(InputStream::new(SMT_EX.into())));
    let token_source = CommonTokenStream::new(_lexer);
    let mut parser = SMTLIBv2Parser::new(Box::new(token_source));
    let listener = Box::new(Listener {
        vng: VarNameGenerator {
            basename: "GEN".to_string(),
            counter: 0,
        },
        new_vars: BTreeMap::new(),
    });
    let lid = parser.add_parse_listener(listener);
    let result = parser.script();

    let listener = parser.remove_parse_listener(lid);
    println!("dict {:?}", listener.new_vars);

    let mut decls = listener
        .new_vars
        .iter()
        .map(|(k, v)| format!("(declare-const {} {})", k, v.typestr()))
        .map(|ds| cmd_from(ds))
        .collect::<Vec<Rc<dyn ParserRuleContext + 'static>>>();

    let script = result.unwrap();

    // this clone might be expensive, not sure if it is recursive
    let mut kids = script.get_children_full().borrow().clone();

    decls.append(&mut kids);
    script.get_children_full().replace(decls);
    println!("{}", script.get_text());
}

fn cmd_from(cmd: String) -> Rc<dyn ParserRuleContext + 'static> {
    let mut _lexer = SMTLIBv2Lexer::new(Box::new(InputStream::new(cmd)));
    let token_source = CommonTokenStream::new(_lexer);
    let mut parser = SMTLIBv2Parser::new(Box::new(token_source));
    parser.command().unwrap()
}

fn tmnl_ctxt_from(token: &str) -> TerminalNode {
    let ot = OwningToken {
        token_type: TOKEN_MIN_USER_TOKEN_TYPE,
        channel: TOKEN_DEFAULT_CHANNEL,
        text: token.to_string(),
        start: -1,
        stop: -1,
        line: -1,
        column: -1,
        token_index: -1,
        read_only: false,
    };

    let tmnl_ctxt = TerminalNodeCtx { symbol: ot };

    // Not clear if -1 is correct here
    // also if parent can be None
    BaseParserRuleContext::new_parser_ctx(None, -1, tmnl_ctxt)
}

#[derive(Debug, Clone)]
enum SMTlibConst {
    Num(i64),
    Dec(f64),
    Str(String),
    Bin(), // Will add support later
    Hex(), // ditto
}

impl SMTlibConst {
    fn typestr(&self) -> &str {
        match self {
            SMTlibConst::Num(_) => "Int",
            _ => panic!("Unimplemented for non-ints"),
        }
    }
}

struct VarNameGenerator {
    basename: String,
    counter: u32,
}

impl VarNameGenerator {
    fn get_name(&mut self) -> String {
        self.counter = self.counter + 1;
        format!("{}{}", self.basename, self.counter)
    }
}

struct Listener {
    vng: VarNameGenerator,
    new_vars: BTreeMap<String, SMTlibConst>,
}

fn qual_id_from(var: String) -> Rc<Qual_identiferContext> {
    let mut _lexer = SMTLIBv2Lexer::new(Box::new(InputStream::new(var)));
    let token_source = CommonTokenStream::new(_lexer);
    let mut parser = SMTLIBv2Parser::new(Box::new(token_source));
    parser.qual_identifer().unwrap()
}

impl SMTLIBv2Listener for Listener {
    // should add some assertions that these are single parent nodes
    fn exit_term(&mut self, term: &TermContext) {
        match term.spec_constant() {
            Some(sc) => {
                let name = self.vng.get_name();
                sc.numeral()
                    .and_then(|n| n.get_text().parse::<i64>().ok())
                    .map(|n| self.new_vars.insert(name.clone(), SMTlibConst::Num(n)));
                term.get_children_full().replace(vec![qual_id_from(name)]);
                ()
            }
            None => (),
        };
        // term.get_children_full().replace(vec![]);
    }
}

impl ParseTreeListener for Listener {
    fn enter_every_rule(&mut self, ctx: &dyn ParserRuleContext) {
        //        let raw = ctx as *mut dyn ParserRuleContext;
        println!(
            "rule entered {}",
            smtlibv2parser::ruleNames[ctx.get_rule_index()]
        );
    }

    fn exit_every_rule(&mut self, ctx: &dyn ParserRuleContext) {
        println!(
            "rule exited {}",
            smtlibv2parser::ruleNames[ctx.get_rule_index()]
        )
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        exec();
    }
}
