module Latte.CLI where

import Control.Applicative
import System.Console.ArgParser

data MyTest = MyTest FilePath Int
  deriving Show

myTestParser :: ParserSpec MyTest
myTestParser = MyTest
  `parsedBy` reqPos "inputFile" `Descr` "input file path"
  `andBy` optPos 0 "pos2" `Descr` "description for the second argument"

myTestInterface :: IO (CmdLnInterface MyTest)
myTestInterface =
  (`setAppDescr` "top description")
  <$> (`setAppEpilog` "bottom description")
  <$> mkApp myTestParser

