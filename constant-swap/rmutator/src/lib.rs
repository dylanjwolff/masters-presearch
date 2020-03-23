#![feature(try_blocks)]
#![allow(unused_imports)]

extern crate antlr_rust;
#[macro_use]
extern crate lazy_static;

pub mod smtlibv2lexer;
pub mod smtlibv2listener;
pub mod smtlibv2parser;

use crate::smtlibv2parser::IdentifierContext;
use crate::smtlibv2parser::Qual_identiferContext;
use crate::smtlibv2parser::SimpleSymbolContext;
use crate::smtlibv2parser::TermContext;
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
use std::rc::Rc;

const SMT_EX: &'static str = "(set-logic QF_LIA)
(declare-const x Int)
(declare-const y Int)
(assert (= (- x y) (+ (+ x (- y) 1) 4)))
(check-sat)
; unsat
(exit)";

pub fn exec() {
    let mut _lexer = SMTLIBv2Lexer::new(Box::new(InputStream::new(SMT_EX.into())));
    let token_source = CommonTokenStream::new(_lexer);
    let mut parser = SMTLIBv2Parser::new(Box::new(token_source));
    parser.add_parse_listener(Box::new(Listener));
    let result = parser.script();
    print!("{}", result.unwrap().get_text());
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
//need to write mutable visitor to result
struct Listener;

impl SMTLIBv2Listener for Listener {
    fn exit_term(&mut self, term: &TermContext) {
        // term.get_children_full().replace(vec![]);
    }

    fn exit_simpleSymbol(&mut self, ssc: &SimpleSymbolContext) {
        let kids = ssc
            .get_children_full()
            .replace(vec![Rc::new(tmnl_ctxt_from("z"))]);
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
