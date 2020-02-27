{
module Main where
import Data.Char (isSpace, isAlpha, isUpper)
import Control.Monad (liftM2)
}

%name parser
%tokentype { Token }
%error { parseError }

%token
      '::'            { TokenColons }
      '->'            { TokenArrow }
      '=>'            { TokenBigArrow }
      type            { TokenType $$ }
      class_decl      { TokenClassMeta }
      type_decl       { TokenTypeMeta }
      data_decl       { TokenDataMeta }
      '='             { TokenEquals }
      where           { TokenWhere }
      '|'             { TokenOr }
      '['             { TokenOSB }
      ']'             { TokenCSB }
      '('             { TokenOB }
      ')'             { TokenCB }
      '*'             { TokenAny }
      name            { TokenName $$ }
      ","             { TokenComma }

%left '->'
%%

TypeExp  : name                    { Name $1 }
         | type                    { Type $1 }
         | TypeExp '->' TypeExp    { Function $1 $3 }
         | '[' TypeExp ']'         { SBrack $2 }
         | '(' TypeExp ')'         { Brack $2 }

{


parseError :: [Token] -> a
parseError _ = error "Parse error"

data TypeExp
    = Name String
    | Type String
    | Function TypeExp TypeExp
    | SBrack TypeExp
    | Brack TypeExp
    deriving Show

data Token
      = TokenColons
      | TokenArrow
      | TokenBigArrow
      | TokenTimes
      | TokenEquals
      | TokenWhere
      | TokenClassMeta
      | TokenTypeMeta
      | TokenType String
      | TokenDataMeta
      | TokenOr
      | TokenOSB
      | TokenCSB
      | TokenOB
      | TokenCB
      | TokenODir
      | TokenCDir
      | TokenAny
      | TokenName String
      | TokenComma
      | TokenHash
      deriving Show


lexer :: String -> [Token]
lexer [] = []
lexer (c:cs)
      | isSpace c = lexer cs
      | isAlpha c = lexVar (c:cs)
lexer ('=':'>':cs) = TokenBigArrow : lexer cs
lexer ('=':cs) = TokenEquals : lexer cs
lexer ('*':cs) = TokenAny : lexer cs
lexer ('|':cs) = TokenOr : lexer cs
lexer ('[':cs) = TokenOSB : lexer cs
lexer (']':cs) = TokenCSB : lexer cs
lexer ('(':cs) = lexBrackets ('(':cs)
lexer (')':cs) = TokenCB : lexer cs
lexer (':':':':cs) = TokenColons : lexer cs
lexer (',':cs) = TokenComma : lexer cs
lexer ('-':'>':cs) = TokenArrow : lexer cs
lexer ('{':'-':'#':cs) = TokenODir : lexer cs
lexer ('#':'-':'}':cs) = TokenCDir : lexer cs
lexer ('#':cs) = TokenHash : lexer cs

isComma c = c == ','
isBracket c = c == '(' || c == ')' || c == '[' || c == ']'
fand = liftM2 (&&)
isValName = fand (fand (not . isSpace) (not . isComma)) (not . isBracket)

lexVar cs =
   case Prelude.span isValName cs of
      ("class",rest) -> TokenClassMeta : lexer rest
      ("data",rest)  -> TokenDataMeta : lexer rest
      ("type",rest)  -> TokenTypeMeta : lexer rest
      ("where",rest)  -> TokenWhere   : lexer rest
      (c:cs,rest)   ->   if isUpper c then (TokenType (c:cs)) : lexer rest else (TokenName (c:cs)) : lexer rest

lexBrackets ('(':cs) =
    let (cts, next:rest) = Prelude.span isValName cs in
    if next == ')' then TokenName cts : lexer rest else TokenOB : lexer cs

main = getContents >>= print . parser . lexer
}
