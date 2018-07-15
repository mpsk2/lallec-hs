module Latte.CLI where

import Control.Applicative
import System.Console.ArgParser

data CLIOptions = CLIOptions {
      inputFile :: FilePath
    } deriving Show

myTestParser :: ParserSpec CLIOptions
myTestParser = CLIOptions
  `parsedBy` reqPos "inputFile" `Descr` "input file path"

myTestInterface :: IO (CmdLnInterface CLIOptions)
myTestInterface =
  (`setAppDescr` "Latte language compiler")
  <$> mkApp myTestParser

