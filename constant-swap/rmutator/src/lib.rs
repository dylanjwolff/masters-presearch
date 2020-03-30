#![feature(try_blocks)]
#![allow(unused_imports)]
#![allow(warnings, unused)]
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
use crate::smtlibv2parser::SymbolContext;
use crate::smtlibv2parser::TermContext;
use crate::smtlibv2parser::TermContextAttrs;
use antlr_rust::common_token_stream::CommonTokenStream;
use antlr_rust::input_stream::InputStream;
use antlr_rust::parser_rule_context::ParserRuleContextType;
use antlr_rust::parser_rule_context::{BaseParserRuleContext, ParserRuleContext};
use antlr_rust::rule_context::CustomRuleContext;
use antlr_rust::token::OwningToken;
use antlr_rust::token::{TOKEN_DEFAULT_CHANNEL, TOKEN_MIN_USER_TOKEN_TYPE};
use antlr_rust::tree::NodeText;
use antlr_rust::tree::TerminalNode;
use antlr_rust::tree::Tree;
use antlr_rust::tree::{ParseTree, ParseTreeListener, TerminalNodeCtx};
use smtlibv2lexer::SMTLIBv2Lexer;
use smtlibv2listener::SMTLIBv2Listener;
use smtlibv2parser::IdentifierContextAttrs;
use smtlibv2parser::Qual_identiferContextAttrs;
use smtlibv2parser::SMTLIBv2Parser;
use smtlibv2parser::ScriptContextExt;
use smtlibv2parser::SimpleSymbolContextAttrs;
use smtlibv2parser::SymbolContextAttrs;
use smtlibv2parser::TermContextExt;
use std::any::Any;
use std::borrow::BorrowMut;
use std::collections::BTreeMap;
use std::fs;
use std::rc::Rc;
enum AST {
    ANTLR_Node(Vec<AST>),
    ANTLR_Terminal(String),
}
pub fn exec() {
    let smt_ex: String =
        fs::read_to_string("ex.smt2").expect("Something went wrong reading the file");
    let mut _lexer = SMTLIBv2Lexer::new(Box::new(InputStream::new(smt_ex.into())));
    let token_source = CommonTokenStream::new(_lexer);
    let mut parser = SMTLIBv2Parser::new(Box::new(token_source));
    let listener = Box::new(Listener {
        vng: VarNameGenerator {
            basename: "GEN".to_string(),
            counter: 0,
        },
        new_vars: BTreeMap::new(),
        bexps: vec![],
    });
    let lid = parser.add_parse_listener(listener);
    let result = parser.script();

    let listener = parser.remove_parse_listener(lid);
    let mut bav_gen = VarNameGenerator {
        basename: "BAV".to_string(),
        counter: 0,
    };

    println!("BEXP {}", listener.bexps.len());
    let (bav_names, bav_inits) = listener
        .bexps
        .into_iter()
        .map(|term| {
            let t: ParserRuleContextType = Rc::new(term);
            let name = bav_gen.get_name();
            let cmd = cmd_from(format!("(assert (= {} {}))", name, ast_string(&t)));
            (name, cmd)
        })
        .unzip::<String, ParserRuleContextType, Vec<String>, Vec<ParserRuleContextType>>();

    let bool_type = vec![SMTlibConst::Bool()];
    let new_bavs = bav_names.iter().zip(bool_type.iter().cycle());

    let mut decls = listener
        .new_vars
        .iter()
        .chain(new_bavs)
        .map(|(k, v)| format!("(declare-const {} {})", k, v.typestr()))
        .map(|ds| cmd_from(ds))
        .collect::<Vec<Rc<dyn ParserRuleContext + 'static>>>();

    let script: Rc<dyn ParserRuleContext> = result.unwrap();

    // this clone might be expensive, not sure if it is recursive
    let mut kids = script.get_children_full().borrow().clone();

    decls.append(&mut kids);
    script.get_children_full().replace(decls);

    println!("FINAL: {}", ast_string(&script));
}

fn ast_string(ast: &ParserRuleContextType) -> String {
    match ast
        .upcast_any()
        .downcast_ref::<BaseParserRuleContext<TerminalNodeCtx>>()
    {
        Some(tn) => tn.get_text() + " ",
        None => {
            let mut s: String = "".to_owned();
            for child in ast.get_children().iter() {
                s.push_str(&ast_string(child)[..]);
            }
            s
        }
    }
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
    Bool(),
    Bin(), // Will add support later
    Hex(), // ditto
}

impl SMTlibConst {
    fn typestr(&self) -> &str {
        match self {
            SMTlibConst::Num(_) => "Int",
            SMTlibConst::Bool() => "Bool",
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
    bexps: Vec<TermContext>,
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

        let maybe_op = term
            .qual_identifer()
            .and_then(|qi| qi.identifier())
            .and_then(|i| i.symbol())
            .and_then(|s| s.simpleSymbol())
            .and_then(|ss| ss.UndefinedSymbol())
            .map(|us| us.get_text())
            .map(|op| match &op[..] {
                "<" | "=" | "or" | "and" => self
                    .bexps
                    .push(BaseParserRuleContext::copy_from(term, (*term).clone())),
                _ => (),
            });
    }

    fn exit_simpleSymbol(&mut self, ssc: &SimpleSymbolContext) {
        println!("SS PDEF {:?}", ssc.predefSymbol());
        println!("SS UNDEF {:?}", ssc.UndefinedSymbol());
    }
}

impl ParseTreeListener for Listener {
    fn enter_every_rule(&mut self, ctx: &dyn ParserRuleContext) {
        //        let raw = ctx as *mut dyn ParserRuleContext;
        //
        //

        println!(
            "rule entered {}",
            smtlibv2parser::ruleNames[ctx.get_rule_index()]
        );

        match ctx
            .upcast_any()
            .downcast_ref::<BaseParserRuleContext<ScriptContextExt>>()
        {
            Some(_) => println!("ITS A SCRIPT"),
            None => (),
        };
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
