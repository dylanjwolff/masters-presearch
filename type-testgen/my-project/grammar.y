{
module Main where
}

%name parser
%tokentype { Token }
%error { parseError }

%token
      '::'            { TokenColons }
      '->'            { TokenArrow }
      '=>'            { TokenBigArrow }
      type            { TokenTimes }
      ph              { TokenPlaceholder }
      meta            { TokenMetaType }
      '='             { TokenEquals }
      where           { TokenWhere }
      '|'             { TokenOr }
      '['             { TokenOSB }
      ']'             { TokenCSB }
      '('             { TokenOB }
      ')'             { TokenCB }
      '*'             { TokenAny }
      fname           { TokenFname }
      ","             { TokenComma }

%%

TypeExp  : ph                      { PH $1 }
         | type                    { Type $1 }
         | TypeExp '->' TypeExp    { Function $1 $3 }
         | '[' TypeExp ']'         { SBrack $2 }
         | '(' TypeExp ')'         { Brack $2 }

parseError :: [Token] -> a
parseError _ = error "Parse error"

data TypeExp
    = PH String
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
      | TokenPlaceholder
      | TokenMetaType
      | TokenEquals
      | TokenWhere
      | TokenOr
      | TokenOSB
      | TokenCSB
      | TokenOB
      | TokenCB
      | TokenAny
      | TokenFname
      | TokenComma
 deriving Show

lexer :: String -> [Token]
lexer [] = []
lexer (c:cs)
      | isSpace c = lexer cs
      | isAlpha c = lexVar (c:cs)
      | isDigit c = lexNum (c:cs)
lexer ('=':cs) = TokenEquals : lexer cs
lexer ('*':cs) = TokenAny : lexer cs
lexer ('[':cs) = TokenOSB : lexer cs
lexer (']':cs) = TokenCSB : lexer cs
lexer ('(':cs) = TokenOB : lexer cs
lexer (')':cs) = TokenCB : lexer cs
lexer ('::':cs) = TokenColons : lexer cs
lexer (',':cs) = TokenComma : lexer cs
lexer ('->':cs) = TokenArrow : lexer cs
lexer ('=>':cs) = TokenBigArrow : lexer cs

lexNum cs = TokenInt (read num) : lexer rest
      where (num,rest) = span isDigit cs

lexVar cs =
   case span isAlpha cs of
      ("let",rest) -> TokenLet : lexer rest
      ("in",rest)  -> TokenIn : lexer rest
      (var,rest)   -> TokenVar var : lexer rest
