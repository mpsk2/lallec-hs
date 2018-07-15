module Latte.Parser where

import Control.Monad.Except
import Latte.Commons (LatteRunner, Position)
import Latte.Errors
import Latte.Parser.Abs (Program)
import Latte.Parser.Lex (Token)
import Latte.Parser.ErrM
import Latte.Parser.Print
import Latte.Parser.Par (myLexer, pProgram)

type ParseFun a = [Token] -> Err a

myLLexer = myLexer

type Verbosity = Int

run :: (Print a, Show a) => Verbosity -> ParseFun a -> String -> Err a
run v p s = let ts = myLLexer s in p ts

parseProgram :: String -> LatteRunner () (Program Position)
parseProgram program = case run 0 pProgram program of
    Bad s -> throwError $ ParseError s
    Ok tree -> return tree