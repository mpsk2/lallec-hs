module Main where

import Latte.Commons (runLatteRunner)
import Latte.CLI
import Latte.Parser
import System.Console.ArgParser
import System.Exit (exitFailure)

runProgram :: CLIOptions -> IO ()
runProgram opts@(CLIOptions inputFile) = do
    print opts
    str <- readFile inputFile
    let parseRunner = parseProgram str
    parsedProgram <- runLatteRunner () parseRunner
    case parsedProgram of
        Left err -> do
            print err
            exitFailure
        Right program -> print program

main :: IO ()
main = do
    interface <- myTestInterface
    runApp interface runProgram
