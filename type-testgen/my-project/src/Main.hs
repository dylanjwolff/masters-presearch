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
