#!/usr/bin/env stack
-- stack --resolver lts-15.0 script
{-# LANGUAGE OverloadedStrings #-}
import Turtle
import Data.Text
import Data.IORef
import System.Exit

shelln cmd = shell cmd Turtle.empty

argument = "0"
file_path  = decodeString "gcd.m"
(n, e) = splitExtension file_path


main = do
        ec <- (shelln (fromString ("mcc -m " ++ encodeString file_path)))
        let compiled_out = inshell (fromString ("./run_" ++ encodeString n ++ ".sh /usr/local/MATLAB/MATLAB_Runtime/v97/ " ++ argument)) Turtle.empty
            interp_out = inshell (fromString ("matlab -batch '" ++ encodeString n ++ "(" ++ argument ++ ")'")) Turtle.empty in do
                interp_out <- fmap strip $ strict interp_out
                compiled_out <- fmap strip $ strict $ dropn 4 compiled_out
                if (isInfixOf compiled_out interp_out) then exitFailure else exitSuccess

dropn :: Int -> Shell a -> Shell a
dropn n s = Shell (\(FoldShell step begin done) -> do
    ref <- newIORef 0  -- I feel so dirty
    let step' x a = do
            n' <- readIORef ref
            writeIORef ref (n' + 1)
            if n' < n then return x else step x a
    _foldShell s (FoldShell step' begin done) )
