module Main where

import Latte.Commons (runLatteRunner)
import Latte.CLI
import System.Console.ArgParser

runProgram :: CLIOptions -> IO ()
runProgram opts@(CLIOptions inputFile) = do
    print opts
    str <- readFile inputFile
    print str

main :: IO ()
main = do
    interface <- myTestInterface
    runApp interface runProgram