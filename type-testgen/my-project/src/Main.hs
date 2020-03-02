module Main where

import Turtle
import Parser

main :: IO ()
main = do
        putStrLn "hello world"

deQual fdecl =
    case fdecl of
        QFDecl name quals signature ->
            case quals of
                App t v -> replace (t, v) signature


replace (t, v) signature =
    case signature of
        Name n ->
            let Name v' = v in
            if n == v' then t else signature
        Or a b -> Or (replace (t, v) a)  (replace (t, v) b)
        Sep a b -> Sep (replace (t, v) a)  (replace (t, v) b)
        Function a b -> Function (replace (t, v) a)  (replace (t, v) b)
        App a b -> App (replace (t, v) a)  (replace (t, v) b)
        SBrack a -> SBrack (replace (t, v) a)
        Brack a -> Brack (replace (t, v) a)
        otherwise -> signature
