#![feature(try_blocks)]

extern crate antlr_rust;
#[macro_use]
extern crate lazy_static;

pub mod smtlibv2lexer;
pub mod smtlibv2listener;
pub mod smtlibv2parser;

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
