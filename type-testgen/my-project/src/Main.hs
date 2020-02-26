module Main where

import Data.Time.Clock (getCurrentTime)
import System.IO (readFile)
import Language.Haskell.Exts.Parser
import Turtle
import Data.Text
import Data.Char
import Control.Monad

main :: IO ()
main = do
        putStrLn "hello world"


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
      | TokenFname String
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
fand = liftM2 (&&)
isValName = fand (not . isSpace) (not . isComma)

lexVar cs =
   case Prelude.span isValName cs of
      ("class",rest) -> TokenClassMeta : lexer rest
      ("data",rest)  -> TokenDataMeta : lexer rest
      ("type",rest)  -> TokenTypeMeta : lexer rest
      ("where",rest)  -> TokenWhere   : lexer rest
      (c:cs,rest)   ->   if isUpper c then (TokenType (c:cs)) : lexer rest else (TokenFname (c:cs)) : lexer rest

lexBrackets ('(':cs) =
    let (cts, rest) = Prelude.span isValName ('(':cs) in
    if Prelude.last cts == ')' then TokenFname cts : lexer rest else TokenOB : lexer cs
